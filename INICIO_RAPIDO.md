# 🚀 Chatwoot - Início Rápido

## Status Atual

✅ Arquivos configurados:

- `.env` - Variáveis de ambiente com chaves geradas
- `.env.production` - Config para produção
- `GUIA_COMPLETO.md` - Guia passo a passo completo
- `iniciar.bat` - Script automático de inicialização
- `deploy-windows.ps1` - Script PowerShell alternativo

## ⚠️ AÇÃO NECESSÁRIA: Docker Desktop não está rodando

### Passo 1: Iniciar Docker Desktop (VOCÊ PRECISA FAZER)

1. Click no ícone Iniciar do Windows
2. Digite "Docker Desktop"
3. Click para abrir
4. Aguarde o ícone da baleia ficar verde (1-2 min)

### Passo 2: Execute o script automático

Depois do Docker estar rodando, dê duplo-click em:

```
iniciar.bat
```

Esse script vai:

- ✅ Verificar Docker
- ✅ Iniciar PostgreSQL automaticamente
- ✅ Iniciar Redis automaticamente
- ✅ Mostrar status

### Passo 3: Instalar dependências

```powershell
bundle install
pnpm install
bundle exec rails db:prepare
```

### Passo 4: Iniciar aplicação

```powershell
bundle exec rails server
```

### Passo 5: Acessar

```
http://localhost:3000
```

---

## ⚡ Opção Mais Rápida: Railway.app

Não quer configurar tudo localmente?

**Deploy online em 10 minutos:**

1. Acesse: https://railway.app
2. Click "Start a New Project"
3. "Deploy from GitHub repo"
4. Selecione: https://github.com/chatwoot/chatwoot
5. Railway configura tudo automaticamente
6. Recebe URL: `seu-app.up.railway.app`

**Custo: ~$5/mês** (PostgreSQL + Redis + Hosting)

**Benefícios:**

- ✅ Sem configuração local
- ✅ SSL automático
- ✅ Backups automáticos
- ✅ Escalável
- ✅ Pronto para produção

---

## 📋 Checklist

### Ambiente Local (Grátis, mas complexo)

- [ ] Abrir Docker Desktop ← **VOCÊ ESTÁ AQUI**
- [ ] Executar `iniciar.bat`
- [ ] Instalar Ruby 3.3
- [ ] Instalar Node.js 24
- [ ] `bundle install`
- [ ] `pnpm install`
- [ ] `rails db:prepare`
- [ ] `rails server`
- [ ] Acessar http://localhost:3000

### Railway.app (Pago, mas super fácil)

- [ ] Criar conta Railway
- [ ] Deploy repositório
- [ ] Configurar variáveis
- [ ] Acessar aplicação online

---

## 🆘 Precisa de Ajuda?

Abra o arquivo **`GUIA_COMPLETO.md`** para instruções detalhadas de cada passo.

---

## 💡 Minha Recomendação

Se você quer apenas **TESTAR** o Chatwoot:
→ Use **Railway.app** (10 minutos, $5/mês)

Se você quer **DESENVOLVER/MODIFICAR**:
→ Configure **localmente** (seguindo o GUIA_COMPLETO.md)

## O que fazer agora?

1. **Inicie o Docker Desktop** (menu Iniciar do Windows)
2. Aguarde ficar verde/running
3. Dê duplo-click em **`iniciar.bat`**
4. Me avise quando os containers estiverem rodando

Ou me diga se prefere tentar o Railway.app!
