# ⚡ Deploy Rápido do Chatwoot

## 🎯 Opção Mais Rápida: Railway.app (10 minutos)

### 1. Criar conta no Railway

- Acesse: https://railway.app
- Conecte com GitHub

### 2. Fork ou envie código para GitHub

```bash
# No Windows PowerShell, na pasta do projeto:
cd "c:\Users\goohf\Documents\chatwoot-develop (1) - Copia\chatwoot-develop"

# Inicializar git (se ainda não for repo)
git init
git add .
git commit -m "Initial commit"

# Criar repo no GitHub e enviar
git remote add origin https://github.com/SEU-USUARIO/chatwoot.git
git push -u origin main
```

### 3. Deploy no Railway

1. Click "New Project"
2. "Deploy from GitHub repo"
3. Selecione seu repositório
4. Railway detecta automaticamente como Rails app

### 4. Adicionar PostgreSQL

1. No projeto, click "New"
2. "Database" → "Add PostgreSQL"
3. Railway configura `DATABASE_URL` automaticamente

### 5. Adicionar Redis

1. Click "New" novamente
2. "Database" → "Add Redis"
3. Railway configura `REDIS_URL` automaticamente

### 6. Configurar Variáveis de Ambiente

No Railway, vá em Settings → Variables:

```bash
# Gerar no PowerShell:
# -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 64 | % {[char]$_})
SECRET_KEY_BASE=sua_chave_gerada

RAILS_ENV=production
NODE_ENV=production
FRONTEND_URL=${{RAILWAY_STATIC_URL}}

# Email (Gmail exemplo)
MAILER_SENDER_EMAIL=Sua Empresa <noreply@gmail.com>
SMTP_ADDRESS=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=seuemail@gmail.com
SMTP_PASSWORD=senha_app_gmail
SMTP_AUTHENTICATION=login
SMTP_ENABLE_STARTTLS_AUTO=true

# Desabilitar cadastro público
ENABLE_ACCOUNT_SIGNUP=false
```

### 7. Deploy Automático!

- Railway faz deploy automaticamente
- Você recebe uma URL tipo: `chatwoot-production.up.railway.app`

### 8. Configurar Domínio (Opcional)

1. Settings → Networking
2. "Custom Domain"
3. Adicione seu domínio (chat.suaempresa.com)

**Custo: ~$5-10/mês**

---

## 🐳 Opção Docker (VPS) - Mais Controle

### Para Windows (WSL2)

#### 1. Instalar WSL2 e Docker Desktop

```powershell
# PowerShell como Admin
wsl --install
```

Baixe Docker Desktop: https://www.docker.com/products/docker-desktop/

#### 2. No WSL2 (Ubuntu):

```bash
# Copiar projeto
cd ~
cp -r "/mnt/c/Users/goohf/Documents/chatwoot-develop (1) - Copia/chatwoot-develop" ./chatwoot
cd chatwoot

# Copiar e configurar .env
cp .env.production.example .env.production
nano .env.production  # Edite as variáveis

# Deploy!
chmod +x deploy.sh
./deploy.sh deploy
```

#### 3. Acessar

```
http://localhost:3000
```

### Para Servidor Linux (VPS)

#### 1. Conectar no servidor

```bash
ssh root@seu-servidor.com
```

#### 2. Instalar Docker

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

#### 3. Transferir arquivos

```bash
# No Windows (PowerShell):
scp -r "c:\Users\goohf\Documents\chatwoot-develop (1) - Copia\chatwoot-develop" root@servidor:/root/chatwoot
```

#### 4. Deploy

```bash
# No servidor:
cd /root/chatwoot
chmod +x deploy.sh

# Editar .env.production primeiro!
nano .env.production

# Deploy
./deploy.sh deploy
```

#### 5. Configurar domínio e SSL

```bash
# Instalar Certbot
apt install certbot -y

# Obter certificado
certbot certonly --standalone -d chat.suaempresa.com

# Configurar nginx (opcional)
```

---

## 🎈 Opção Heroku - Um Clique

### 1. Click no botão

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/chatwoot/chatwoot/tree/master)

### 2. Preencher formulário

- App name: `sua-empresa-chat`
- Region: United States ou Europe
- Configurar variáveis que aparecem

### 3. Escolher addons

- Heroku Postgres (Mini $5)
- Heroku Redis (Mini $3)

### 4. Deploy!

Heroku faz tudo automaticamente.

**Custo: ~$25-50/mês**

---

## 📊 Comparação Rápida

| Plataforma       | Tempo  | Dificuldade      | Custo/mês | Controle |
| ---------------- | ------ | ---------------- | --------- | -------- |
| **Railway**      | 10 min | ⭐ Fácil         | $5-10     | Médio    |
| **Heroku**       | 5 min  | ⭐⭐ Muito Fácil | $25-50    | Baixo    |
| **Docker VPS**   | 30 min | ⭐⭐⭐ Médio     | $5-12     | Alto     |
| **DigitalOcean** | 15 min | ⭐⭐ Fácil       | $12+      | Alto     |

---

## ✅ Checklist Mínima

Antes de fazer deploy, tenha:

- [ ] **SECRET_KEY_BASE** gerado
- [ ] **SMTP** configurado (Gmail, SendGrid, etc)
- [ ] **Domínio** ou use URL fornecida pela plataforma
- [ ] **Senhas fortes** para Postgres e Redis

---

## 🆘 Problemas Comuns

### "Database connection failed"

```bash
# Verifique se DATABASE_URL está correto
# Railway/Heroku: configurado automaticamente
# Docker: POSTGRES_PASSWORD deve estar igual no .env
```

### "Redis connection failed"

```bash
# Verifique REDIS_URL
# Railway/Heroku: configurado automaticamente
# Docker: REDIS_PASSWORD deve estar correto
```

### "Email não está enviando"

```bash
# Gmail requer "Senha de App":
# 1. Ative verificação em 2 etapas
# 2. https://myaccount.google.com/apppasswords
# 3. Crie senha para "Mail"
# 4. Use essa senha no SMTP_PASSWORD
```

### "ActionCable não conecta"

```bash
# Certifique-se que FRONTEND_URL está correto
# Deve ser https:// em produção
```

---

## 🎯 Recomendação Final

**Para começar HOJE:**
👉 Use **Railway.app** - mais fácil e barato

**Para controle total:**
👉 Use **Docker + Hetzner** - melhor custo-benefício

**Para não pensar:**
👉 Use **Heroku** - só clicar e funciona

---

## 📞 Próximos Passos

Escolha uma opção e me diga:

1. Qual plataforma prefere?
2. Já tem domínio?
3. Precisa de ajuda com qual parte?

Posso ajudar a configurar passo a passo! 🚀
