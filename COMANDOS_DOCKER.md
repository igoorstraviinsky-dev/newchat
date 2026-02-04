# 🐳 Comandos Docker para Chatwoot - Windows

## 🚀 Deploy Inicial

```powershell
# 1. Subir todos os containers
docker-compose -f docker-compose.prod.yml up -d

# 2. Aguardar containers iniciarem (30-60 segundos)
Start-Sleep -Seconds 45

# 3. Preparar banco de dados (criar tabelas, seed data)
docker-compose -f docker-compose.prod.yml exec rails bundle exec rails db:chatwoot_prepare

# 4. Verificar status
docker-compose -f docker-compose.prod.yml ps
```

**Acesse**: http://localhost:3000

---

## 📊 Comandos Úteis

### Ver Logs

```powershell
# Todos os serviços
docker-compose -f docker-compose.prod.yml logs -f

# Apenas Rails
docker-compose -f docker-compose.prod.yml logs -f rails

# Apenas Sidekiq (background jobs)
docker-compose -f docker-compose.prod.yml logs -f sidekiq

# Apenas Postgres
docker-compose -f docker-compose.prod.yml logs -f postgres
```

### Status dos Containers

```powershell
# Ver status
docker-compose -f docker-compose.prod.yml ps

# Ver uso de recursos
docker stats
```

### Reiniciar Serviços

```powershell
# Reiniciar tudo
docker-compose -f docker-compose.prod.yml restart

# Reiniciar apenas Rails
docker-compose -f docker-compose.prod.yml restart rails

# Reiniciar apenas Sidekiq
docker-compose -f docker-compose.prod.yml restart sidekiq
```

### Parar/Remover

```powershell
# Parar containers (dados preservados)
docker-compose -f docker-compose.prod.yml stop

# Remover containers (dados preservados nos volumes)
docker-compose -f docker-compose.prod.yml down

# CUIDADO: Remover TUDO incluindo volumes (perde dados!)
docker-compose -f docker-compose.prod.yml down -v
```

---

## 🔧 Manutenção

### Atualizar Chatwoot

```powershell
# Baixar nova versão
docker-compose -f docker-compose.prod.yml pull

# Recriar containers
docker-compose -f docker-compose.prod.yml up -d

# Rodar migrações
docker-compose -f docker-compose.prod.yml exec rails bundle exec rails db:migrate
```

### Backup do Banco

```powershell
# Criar backup
docker-compose -f docker-compose.prod.yml exec -T postgres pg_dump -U postgres chatwoot_production > backup_$(Get-Date -Format 'yyyyMMdd_HHmmss').sql

# Restaurar backup
Get-Content backup_20260204_103000.sql | docker-compose -f docker-compose.prod.yml exec -T postgres psql -U postgres chatwoot_production
```

### Rails Console (Debugging)

```powershell
docker-compose -f docker-compose.prod.yml exec rails bundle exec rails console
```

### Limpar Logs e Cache

```powershell
docker-compose -f docker-compose.prod.yml exec rails bundle exec rails log:clear
docker-compose -f docker-compose.prod.yml exec rails bundle exec rails tmp:clear
```

---

## 🆘 Troubleshooting

### Containers não iniciam

```powershell
# Ver logs de erro
docker-compose -f docker-compose.prod.yml logs

# Recriar containers do zero
docker-compose -f docker-compose.prod.yml down
docker-compose -f docker-compose.prod.yml up -d
```

### Banco de dados com erro

```powershell
# Resetar banco (CUIDADO: perde dados!)
docker-compose -f docker-compose.prod.yml down -v
docker-compose -f docker-compose.prod.yml up -d
Start-Sleep -Seconds 30
docker-compose -f docker-compose.prod.yml exec rails bundle exec rails db:chatwoot_prepare
```

### "Port already in use"

```powershell
# Ver o que está usando a porta 3000
netstat -ano | findstr :3000

# Matar processo (substitua PID)
taskkill /PID <PID> /F

# Ou mudar porta no docker-compose.prod.yml:
# ports: - '3001:3000'
```

### Redis connection failed

```powershell
# Verificar se Redis está rodando
docker-compose -f docker-compose.prod.yml ps redis

# Testar conexão
docker-compose -f docker-compose.prod.yml exec redis redis-cli -a BsLdIExY2Jrjco8OtvhnQ11FmT5AgKVbH ping
```

---

## 📈 Monitoramento

### Ver uso de memória/CPU

```powershell
docker stats --no-stream
```

### Espaço em disco

```powershell
# Volumes
docker volume ls

# Ver tamanho
docker system df
```

### Limpar espaço

```powershell
# Limpar imagens não usadas
docker image prune -a

# Limpar tudo (CUIDADO!)
docker system prune -a --volumes
```

---

## 🎯 Workflow Completo

```powershell
# 1. INICIAR
docker-compose -f docker-compose.prod.yml up -d

# 2. VERIFICAR
docker-compose -f docker-compose.prod.yml ps
docker-compose -f docker-compose.prod.yml logs -f

# 3. ACESSAR
# Abrir http://localhost:3000

# 4. PARAR (quando terminar)
docker-compose -f docker-compose.prod.yml stop

# 5. REINICIAR (outro dia)
docker-compose -f docker-compose.prod.yml start
```
