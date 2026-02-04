@echo off
echo ========================================
echo   CHATWOOT - Iniciar Aplicacao
echo ========================================
echo.

REM Verificar Docker
echo [1/4] Verificando Docker...
docker ps >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ❌ Docker Desktop não está rodando!
    echo.
    echo Por favor:
    echo 1. Abra o Docker Desktop
    echo 2. Aguarde até estar "running" verde
    echo 3. Execute este script novamente
    echo.
    pause
    exit /b 1
)
echo ✅ Docker rodando

REM Verificar Postgres
echo.
echo [2/4] Verificando PostgreSQL...
docker ps | findstr chatwoot_postgres >nul
if %errorlevel% neq 0 (
    echo Iniciando PostgreSQL...
    docker run -d --name chatwoot_postgres -e POSTGRES_DB=chatwoot -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=LljhmBUNg7oIJTDvXcrQiddOeZfV3Fa6W -p 5432:5432 -v chatwoot_pg_data:/var/lib/postgresql/data --restart unless-stopped pgvector/pgvector:pg16
    timeout /t 5 >nul
)
echo ✅ PostgreSQL rodando

REM Verificar Redis
echo.
echo [3/4] Verificando Redis...
docker ps | findstr chatwoot_redis >nul
if %errorlevel% neq 0 (
    echo Iniciando Redis...
    docker run -d --name chatwoot_redis -p 6379:6379 -v chatwoot_redis_data:/data --restart unless-stopped redis:7-alpine redis-server --requirepass BsLdIExY2Jrjco8OtvhnQ11FmT5AgKVbH
    timeout /t 3 >nul
)
echo ✅ Redis rodando

REM Mostrar status
echo.
echo [4/4] Status dos containers:
docker ps --filter "name=chatwoot_" --format "table {{.Names}}\t{{.Status}}"

echo.
echo ========================================
echo ✅ Containers prontos!
echo ========================================
echo.
echo Proximos passos:
echo.
echo 1. bundle install    (instalar gems Ruby)
echo 2. pnpm install      (instalar pacotes Node)
echo 3. rails db:prepare  (preparar banco)
echo 4. rails server      (iniciar aplicacao)
echo.
echo Ou execute: foreman start -f Procfile.dev
echo.
echo Acesse: http://localhost:3000
echo.
pause
