# 🆘 SOLUÇÃO: Repositório não encontrado / não salvo

Se o Railway não está aceitando o repositório "chatwoot/chatwoot", você precisa fazer um **FORK** (uma cópia) para o seu GitHub primeiro.

## ✅ PASSO 1: Fazer o Fork (Cópia)

1. Acesse este link no navegador:
   👉 **https://github.com/chatwoot/chatwoot/fork**

2. Click no botão verde: **"Create fork"**
   - Isso vai criar uma cópia do Chatwoot no **SEU** GitHub (ex: `seu-usuario/chatwoot`).

---

## ✅ PASSO 2: Conectar no Railway

1. Volte para o **https://railway.app**
2. Click **"New Project"**
3. Click **"Deploy from GitHub repo"**
4. Agora **NÃO** busque por "chatwoot"
5. Busque pelo **SEU** usuário ou **"chatwoot"** na lista dos SEUS repositórios.
   - Deve aparecer: `seu-usuario/chatwoot`
6. Clique nele → **"Deploy Now"**

---

## 🚀 PASSO 3: Continuar Configuração

Assim que o projeto for criado:

1. Adicione **Database → PostgreSQL**
2. Adicione **Database → Redis**
3. Adicione as **Variáveis** (copy/paste abaixo)

```env
SECRET_KEY_BASE=T5ZwAsKeyEn8ikdl0MDLV1v6IxzjfYp3JhH7BQoRq4c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9
RAILS_ENV=production
NODE_ENV=production
FRONTEND_URL=${{RAILWAY_STATIC_URL}}
FORCE_SSL=true
ENABLE_ACCOUNT_SIGNUP=true
```

## ✨ Resumo

O problema acontece porque você tentou usar o repositório oficial diretamente. Fazendo o **FORK** (Passo 1), o repositório passa a ser seu e o Railway consegue salvar e fazer deploy.
