# ========================================
# CHATWOOT - SCRIPT DE DEPLOY WINDOWS
# ========================================
# Execute este script após copiar projeto para pasta sem espaços

# Cores
$Green = "Green"
$Yellow = "Yellow"
$Red = "Red"

Write-Host "`n===========================================`n" -ForegroundColor $Green
Write-Host "   CHATWOOT - Deploy Automático Windows" -ForegroundColor $Green
Write-Host "`n===========================================`n" -ForegroundColor $Green

# Função para verificar Docker
function Check-Docker {
    Write-Host "[1/6] Verificando Docker..." -ForegroundColor $Yellow
    
    $dockerInstalled = Get-Command docker -ErrorAction SilentlyContinue
    if (-not $dockerInstalled) {
        Write-Host "❌ Docker não encontrado!" -ForegroundColor $Red
        Write-Host "Instale Docker Desktop: https://www.docker.com/products/docker-desktop/" -ForegroundColor $Yellow
        exit 1
    }
    
    Write-Host "✅ Docker instalado" -ForegroundColor $Green
}

# Função para parar/limpar containers antigos
function Clean-Old-Containers {
    Write-Host "`n[2/6] Limpando containers antigos..." -ForegroundColor $Yellow
    
    docker stop chatwoot_postgres chatwoot_redis 2>$null
    docker rm chatwoot_postgres chatwoot_redis 2>$null
    
    Write-Host "✅ Limpeza concluída" -ForegroundColor $Green
}

# Função para iniciar PostgreSQL
function Start-Postgres {
    Write-Host "`n[3/6] Iniciando PostgreSQL..." -ForegroundColor $Yellow
    
    docker run -d `
        --name chatwoot_postgres `
        -e POSTGRES_DB=chatwoot `
        -e POSTGRES_USER=postgres `
        -e POSTGRES_PASSWORD=LljhmBUNg7oIJTDvXcrQiddOeZfV3Fa6W `
        -p 5432:5432 `
        -v chatwoot_pg_data:/var/lib/postgresql/data `
        --restart unless-stopped `
        pgvector/pgvector:pg16
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ PostgreSQL iniciado" -ForegroundColor $Green
    } else {
        Write-Host "❌ Erro ao iniciar PostgreSQL" -ForegroundColor $Red
        exit 1
    }
}

# Função para iniciar Redis
function Start-Redis {
    Write-Host "`n[4/6] Iniciando Redis..." -ForegroundColor $Yellow
    
    docker run -d `
        --name chatwoot_redis `
        -p 6379:6379 `
        -v chatwoot_redis_data:/data `
        --restart unless-stopped `
        redis:7-alpine redis-server --requirepass BsLdIExY2Jrjco8OtvhnQ11FmT5AgKVbH
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Redis iniciado" -ForegroundColor $Green
    } else {
        Write-Host "❌ Erro ao iniciar Redis" -ForegroundColor $Red
        exit 1
    }
}

# Função para aguardar serviços
function Wait-For-Services {
    Write-Host "`n[5/6] Aguardando serviços ficarem prontos..." -ForegroundColor $Yellow
    Start-Sleep -Seconds 10
    Write-Host "✅ Serviços prontos" -ForegroundColor $Green
}

# Função para mostrar status
function Show-Status {
    Write-Host "`n[6/6] Status dos serviços:`n" -ForegroundColor $Yellow
    docker ps --filter "name=chatwoot_" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    
    Write-Host "`n===========================================`n" -ForegroundColor $Green
    Write-Host "✅ Postgres e Redis estão rodando!" -ForegroundColor $Green
    Write-Host "`n===========================================`n" -ForegroundColor $Green
    
    Write-Host "`nPróximos passos:`n"
    Write-Host "1. Configure o arquivo .env com as credenciais"
    Write-Host "2. Instale as dependências: bundle install && pnpm install"
    Write-Host "3. Prepare o banco: rails db:prepare"
    Write-Host "4. Inicie o servidor: rails s`n"
    
    Write-Host "Ou use Railway.app para deploy rápido online:`n"
    Write-Host "https://railway.app`n" -ForegroundColor $Yellow
    
    Write-Host "Conexões:"
    Write-Host "  PostgreSQL: localhost:5432"
    Write-Host "  Database: chatwoot"
    Write-Host "  User: postgres"
    Write-Host "  Password: LljhmBUNg7oIJTDvXcrQiddOeZfV3Fa6W`n"
    
    Write-Host "  Redis: localhost:6379"
    Write-Host "  Password: BsLdIExY2Jrjco8OtvhnQ11FmT5AgKVbH`n"
}

# Executar tudo
Check-Docker
Clean-Old-Containers
Start-Postgres
Start-Redis
Wait-For-Services
Show-Status
