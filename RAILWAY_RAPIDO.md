# 🚀 DEPLOY RAILWAY - GUIA RÁPIDO (10 MINUTOS)

## ✅ PASSO A PASSO VISUAL

### 1️⃣ Login Railway (30 seg)

- ✅ Janela do navegador vai abrir automaticamente
- Click: **"Login with GitHub"**
- Autorize Railway

### 2️⃣ Criar Projeto (1 min)

- Click: **"New Project"**
- Escolha: **"Deploy from GitHub repo"**
- Selecione: **chatwoot/chatwoot** (repo oficial)

### 3️⃣ Adicionar Banco de Dados (1 min)

- Click: botão **"+ New"**
- Escolha: **"Database" → "PostgreSQL"**
- Aguarde criar

- Click: botão **"+ New"** novamente
- Escolha: **"Database" → "Redis"**
- Aguarde criar

### 4️⃣ Configurar Variáveis (2 min)

- Click no serviço **"chatwoot"**
- Tab: **"Variables"**
- Click: **"+ New Variable"**

**Cole estas variáveis:**

```
SECRET_KEY_BASE=T5ZwAsKeyEn8ikdl0MDLV1v6IxzjfYp3JhH7BQoRq4c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9
RAILS_ENV=production
NODE_ENV=production
FRONTEND_URL=${{RAILWAY_STATIC_URL}}
FORCE_SSL=true
ENABLE_ACCOUNT_SIGNUP=true
```

### 5️⃣ Aguardar Deploy (5 min)

- Railway inicia deploy automaticamente
- Veja progresso: tab **"Deployments"**
- Aguarde aparecer: ✅ **"Success"**

### 6️⃣ Acessar Aplicação! 🎉

- Tab: **"Settings"**
- Seção: **"Networking"**
- Click na URL: **https://chatwoot-xxxx.up.railway.app**

### 7️⃣ Criar Conta (30 seg)

- **"Create an Account"**
- Preencha dados
- Primeira conta = Admin automático

---

## 🎯 ATALHOS

**Variáveis já prontas (copie/cole):**

```env
SECRET_KEY_BASE=T5ZwAsKeyEn8ikdl0MDLV1v6IxzjfYp3JhH7BQoRq4c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9
RAILS_ENV=production
NODE_ENV=production
FRONTEND_URL=${{RAILWAY_STATIC_URL}}
FORCE_SSL=true
ENABLE_ACCOUNT_SIGNUP=true
MAILER_SENDER_EMAIL=Chatwoot <noreply@railway.app>
```

**Repositório Chatwoot oficial:**

```
https://github.com/chatwoot/chatwoot
```

---

## ⏱️ TEMPO ESTIMADO

- Login: 30 seg
- Criar projeto: 1 min
- Databases: 1 min
- Variáveis: 2 min
- Deploy: 5 min
- **TOTAL: ~10 minutos**

---

## 🆘 PROBLEMAS?

**Deploy falhou?**

- Check logs: tab "Deployments"
- Variáveis corretas?

**URL não abre?**

- Aguarde deploy completar (✅ Success)
- Pode levar até 5 min primeira vez

**Sem GitHub?**

- Pode usar email/senha OAuth

---

✨ **BOA SORTE!** Em 10 minutos você terá o Chatwoot rodando!
