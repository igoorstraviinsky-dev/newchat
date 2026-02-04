# 🚀 GUIA COMPLETO - Deploy Chatwoot no Windows

## ⚠️ PASSO CRÍTICO: Iniciar Docker Desktop

### 1. Abra o Docker Desktop

- Procure "Docker Desktop" no menu Iniciar do Windows
- Clique para abrir
- Aguarde até aparecer "Docker Desktop is running" (ícone verde na bandeja)
- **Isso pode levar 1-2 minutos**

### 2. Verifique se está rodando

```powershell
docker ps
```

Se funcionar, está pronto! Continue para o Passo 3.

---

## 📦 Passo 3: Iniciar Banco de Dados (PostgreSQL)

```powershell
docker run -d `
  --name chatwoot_postgres `
  -e POSTGRES_DB=chatwoot `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=LljhmBUNg7oIJTDvXcrQiddOeZfV3Fa6W `
  -p 5432:5432 `
  -v chatwoot_pg_data:/var/lib/postgresql/data `
  --restart unless-stopped `
  pgvector/pgvector:pg16
```

✅ **Resultado esperado**: `<container_id>` (ID do container)

---

## 🔴 Passo 4: Iniciar Redis (Cache)

```powershell
docker run -d `
  --name chatwoot_redis `
  -p 6379:6379 `
  -v chatwoot_redis_data:/data `
  --restart unless-stopped `
  redis:7-alpine redis-server --requirepass BsLdIExY2Jrjco8OtvhnQ11FmT5AgKVbH
```

✅ **Resultado esperado**: `<container_id>` (ID do container)

---

## ✅ Passo 5: Verificar Containers

```powershell
docker ps
```

Você deve ver:

- `chatwoot_postgres` rodando
- `chatwoot_redis` rodando

---

## 🔧 Passo 6: Instalar Dependências do Projeto

### 6.1 Verificar Ruby

```powershell
ruby --version
```

**Se não tiver Ruby instalado:**

1. Baixe: https://rubyinstaller.org/downloads/
2. Instale Ruby+Devkit 3.3.x (WITH DEVKIT)
3. Durante instalação, marque "Add to PATH"
4. Reinicie PowerShell

### 6.2 Verificar Node.js e pnpm

```powershell
node --version
pnpm --version
```

**Se não tiver Node/pnpm:**

```powershell
# Instalar Node.js 24.x
winget install OpenJS.NodeJS.LTS

# Instalar pnpm
npm install -g pnpm@10
```

### 6.3 Instalar Bundler (Ruby)

```powershell
gem install bundler
```

---

## 📚 Passo 7: Instalar Dependências do Chatwoot

```powershell
# Navegar para pasta do projeto
cd "C:\Users\goohf\Documents\chatwoot-develop (1) - Copia\chatwoot-develop"

# Instalar gems Ruby
bundle install

# Instalar pacotes Node
pnpm install
```

⏱️ **Isso pode levar 5-15 minutos**

---

## 🗄️ Passo 8: Preparar Banco de Dados

```powershell
# Criar banco e rodar migrações
bundle exec rails db:prepare

# OU se der erro, use:
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
```

---

## 🚀 Passo 9: Iniciar Chatwoot!

### Opção A: Desenvolvimento (Recomendado)

```powershell
# Terminal 1 - Rails
bundle exec rails server

# Terminal 2 (novo PowerShell) - Vite (Frontend)
pnpm run dev

# Terminal 3 (novo PowerShell) - Sidekiq (Background jobs)
bundle exec sidekiq
```

### Opção B: Usando Foreman (Tudo junto)

```powershell
gem install foreman
foreman start -f Procfile.dev
```

---

## 🎉 Passo 10: Acessar Aplicação!

Abra navegador em:

```
http://localhost:3000
```

### Criar Primeira Conta

1. Click em "Sign Up"
2. Preencha seus dados
3. Crie sua conta admin
4. Faça login

---

## 🆘 Troubleshooting

### "Docker daemon not running"

- Abra Docker Desktop
- Aguarde até estar "running"

### "Port 3000 already in use"

```powershell
# Ver o que está usando
netstat -ano | findstr :3000

# Matar processo (substitua PID)
taskkill /PID <PID> /F
```

### "Bundle install falhou"

```powershell
# Instalar build tools
ridk install
# Escolha opção 3 (MSYS2 and MINGW)
```

### "pnpm install falhou"

```powershell
# Limpar cache
pnpm store prune
pnpm install --force
```

### "Database connection failed"

Verifique se Postgres está rodando:

```powershell
docker ps | findstr postgres
```

---

## 🎯 Resumo Rápido (se tudo já instalado)

```powershell
# 1. Garantir Docker rodando
docker ps

# 2. Subir Postgres e Redis (comandos acima)

# 3. Preparar projeto
cd "C:\Users\goohf\Documents\chatwoot-develop (1) - Copia\chatwoot-develop"
bundle install
pnpm install
bundle exec rails db:prepare

# 4. Iniciar (3 terminais)
bundle exec rails server
pnpm run dev
bundle exec sidekiq

# 5. Acessar
http://localhost:3000
```

---

## 📞 Próximos Passos Após Login

1. ✅ Configure seu perfil
2. ✅ Crie sua primeira "Inbox" (canal de atendimento)
3. ✅ Teste enviando mensagens
4. ✅ Explore configurações

---

## 💡 Alternativa MUITO Mais Fácil: Railway.app

Se isso parecer complicado:

1. Acesse: https://railway.app
2. Conecte com GitHub
3. Deploy do repositório oficial: https://github.com/chatwoot/chatwoot
4. Railway configura PostgreSQL + Redis automaticamente
5. Aplicação online em 10 minutos
6. Custo: ~$5/mês

**Link direto**: https://railway.app/template/chatwoot
