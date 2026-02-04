# ⚡ AÇÃO IMEDIATA - 3 PASSOS

## 1️⃣ Abra Railway.app

Já deve estar aberto no navegador. Se não:

```
https://railway.app
```

## 2️⃣ Execute no Railway (5 clicks)

- Click: "Login with GitHub"
- Click: "New Project" → "Deploy from GitHub repo"
- Busque: `chatwoot/chatwoot`
- Click: "+ New" → PostgreSQL
- Click: "+ New" → Redis

## 3️⃣ Configure Variáveis (copy/paste)

Click serviço "chatwoot" → Tab "Variables" → Cole:

```
SECRET_KEY_BASE=T5ZwAsKeyEn8ikdl0MDLV1v6IxzjfYp3JhH7BQoRq4c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9
RAILS_ENV=production
NODE_ENV=production
FRONTEND_URL=${{RAILWAY_STATIC_URL}}
FORCE_SSL=true
ENABLE_ACCOUNT_SIGNUP=true
```

## ✨ RESULTADO

- Deploy automático (5 min)
- Acesse URL em Settings → Networking
- **APP RODANDO!**

---

**TUDO PRONTO. SÓ FAZER ISSO ↑**
