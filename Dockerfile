# Base image matching our local Ruby version
FROM ruby:3.3.10-slim-bookworm

# Install essential system dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    libpq-dev \
    libvips \
    pkg-config \
    cmake \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20 (LTS sufficient for Chatwoot/Rails usually) or match local 24
# Using a setup script for Node
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm@9.x

# Set working directory
WORKDIR /app

# Set environment variables
ENV RAILS_ENV=production \
    NODE_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT=development:test \
    BUNDLE_PATH=/usr/local/bundle \
    RAILS_SERVE_STATIC_FILES=true

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock .ruby-version ./

# Install Ruby gems
# Retry bundle install on failure, and use jobs for speed
RUN bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Copy package.json and pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./

# Install Node dependencies
RUN pnpm install --frozen-lockfile --prod

# Copy the rest of the application code
COPY . .

# Precompile assets
# We need dummy env vars for assets:precompile to not crash on missing DB/Redis
RUN SECRET_KEY_BASE=dummy \
    RAILS_ENV=production \
    bundle exec rake assets:precompile

# Expose port
EXPOSE 3000

# Start script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Default command
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
