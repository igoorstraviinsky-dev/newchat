# 🌐 ABRIR RAILWAY.APP - INSTRUÇÕES

## ⚠️ Se o navegador não abriu automaticamente

### Opção 1: Abrir Manualmente

1. Abra seu navegador (Chrome, Edge, Firefox, etc)
2. Copie e cole esta URL:

```
https://railway.app
```

### Opção 2: Usar PowerShell

Abra PowerShell e execute:

```powershell
Start-Process "https://railway.app"
```

### Opção 3: Tentar navegador específico

```powershell
# Edge
Start-Process msedge "https://railway.app"

# Chrome
Start-Process chrome "https://railway.app"

# Firefox
Start-Process firefox "https://railway.app"
```

---

## 📋 APÓS ABRIR RAILWAY.APP

### Passo 1: Login

- Click "Login with GitHub"
- Autorize Railway

### Passo 2: Criar Projeto

- "New Project"
- "Deploy from GitHub repo"
- Busque: "chatwoot"

### Passo 3: Databases

- "+ New" → PostgreSQL
- "+ New" → Redis

### Passo 4: Variáveis (COPIE ISTO)

```
SECRET_KEY_BASE=T5ZwAsKeyEn8ikdl0MDLV1v6IxzjfYp3JhH7BQoRq4c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9
RAILS_ENV=production
NODE_ENV=production
FRONTEND_URL=${{RAILWAY_STATIC_URL}}
FORCE_SSL=true
ENABLE_ACCOUNT_SIGNUP=true
```

### Passo 5: Deploy

- Aguarde 5 minutos

### Passo 6: Acessar

- Settings → Networking → Click URL
- 🎉 APP RODANDO!

---

**URL DIRETO:** https://railway.app

**ME AVISE:**

- Conseguiu abrir?
- Em qual passo está?
- Algum erro?
