# 🚀 DEPLOY FINAL - Passo a Passo Manual Rápido

## ✅ O Que Já Está Pronto

**Containers Docker (RODANDO):**

- ✅ PostgreSQL na porta 5432
- ✅ Redis na porta 6379
- ✅ Dados persistentes configurados

**Ambiente:**

- ✅ Node.js v24.13.0
- ✅ pnpm v10
- ✅ Arquivos .env configurados

**Faltando:**

- ❌ Ruby 3.3 (instalando via winget - travado)

---

## 🎯 SOLUÇÃO ALTERNATIVA RÁPIDA: Railway.app

Como a instalação do Ruby está demorando, a forma MAIS RÁPIDA de ter o Chatwoot rodando HOJE é:

### 📱 Deploy Railway.app (10 minutos - RECOMENDADO)

1. **Acesse**: https://railway.app
2. **Sign Up** com GitHub
3. **New Project** → "Deploy from GitHub Repo"
4. **Fork** este repo: https://github.com/chatwoot/chatwoot
5. Selecione seu fork
6. Railway detecta automaticamente
7. **Add PostgreSQL** (botão "New" → Database → PostgreSQL)
8. **Add Redis** (botão "New" → Database → Redis)
9. **Configure variáveis** (Settings → Variables):
   ```
   SECRET_KEY_BASE=T5ZwAsKeyEn8ikdl0MDLV1v6IxzjfYp3JhH7BQoRq4c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9
   FRONTEND_URL=${{RAILWAY_STATIC_URL}}
   RAILS_ENV=production
   NODE_ENV=production
   ```
10. **Deploy** automático
11. **Acesse** sua URL: `seu-app.up.railway.app`

**Custo**: ~$5/mês  
**Tempo**: 10 minutos  
**Resultado**: Aplicação online com SSL, backups automáticos

---

## 🖥️ OU: Completar Instalação Local (se preferir)

### Opção 1: Instalar Ruby Manualmente (5 minutos)

1. **Baixe**: https://rubyinstaller.org/downloads/
   - Escolha: **Ruby+Devkit 3.3.6-1 (x64)**
2. **Instale**:
   - ✅ Marque "Add to PATH"
   - ✅ Marque "Run ridk install"
3. **Na janela ridk**: escolha opção **3** (MSYS2 and MINGW development toolchain)
4. **Aguarde** instalação (~2-3 min)
5. **Reinicie** PowerShell
6. **Verifique**: `ruby --version` (deve mostrar 3.3.x)

### Opção 2: Cancelar winget e usar Chocolatey

```powershell
# Instalar Chocolatey (se não tiver)
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Instalar Ruby
choco install ruby --version=3.3.6 -y

# Reiniciar terminal
refreshenv

# Verificar
ruby --version
```

---

## 📦 Após Ruby Instalado - Passos Finais

```powershell
# Navegar para projeto
cd "C:\Users\goohf\Documents\chatwoot-develop (1) - Copia\chatwoot-develop"

# Instalar bundler
gem install bundler

# Instalar dependências (~5-10 min)
bundle install
pnpm install

# Preparar banco de dados
bundle exec rails db:prepare

# Iniciar aplicação (3 terminais)
# Terminal 1:
bundle exec rails server

# Terminal 2:
pnpm run dev

# Terminal 3:
bundle exec sidekiq

# OU tudo junto:
gem install foreman
foreman start -f Procfile.dev
```

**Acesse**: http://localhost:3000

---

## ⚡ Minha Recomendação AGORA

### 🏆 Melhor opção: Railway.app

**Por quê?**

- ✅ 10 minutos vs horas de troubleshooting
- ✅ Online, acessível de qualquer lugar
- ✅ SSL/HTTPS automático
- ✅ Backups automáticos
- ✅ PostgreSQL + Redis gerenciados
- ✅ $5/mês (café por mês)
- ✅ Escalável
- ✅ Deploy contínuo

**Local é bom para:**

- Desenvolvimento ativo
- Customizações
- Testes offline

**Railway é melhor para:**

- Usar agora
- Demonstrações
- Produção pequena/média
- Não quer configurar ambiente

---

## 🎯 Próxima Ação

**ME DIGA:**

**A)** Vou usar Railway.app → **Te guio passo a passo**

**B)** Vou instalar Ruby manualmente → **Depois continuo os comandos**

**C)** Continuo aguardando winget → **Pode demorar mais 10-20 min**

## 📊 Status Atual - Resumo

```
✅ Docker Desktop: RODANDO
✅ PostgreSQL: CONTAINER UP (porta 5432)
✅ Redis: CONTAINER UP (porta 6379)
✅ Node.js: v24.13.0 INSTALADO
✅ pnpm: v10 INSTALADO
⏳ Ruby: INSTALANDO VIA WINGET (travado em ~70%)
✅ Arquivos .env: CONFIGURADOS
✅ Scripts: PRONTOS
```

**Falta para rodar local:**

1. Ruby instalar (5 min manual)
2. bundle install (5-10 min)
3. pnpm install (3-5 min)
4. rails db:prepare (2 min)
5. rails server (instantâneo)

**Total estimado**: 15-25 minutos após Ruby

**OU Railway em**: 10 minutos total 🚀
