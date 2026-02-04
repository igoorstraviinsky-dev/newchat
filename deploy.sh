#!/bin/bash

# ========================================
# CHATWOOT - SCRIPT DE DEPLOY
# ========================================
# Este script facilita o deploy do Chatwoot em produção

set -e  # Para na primeira erro

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}"
cat << "EOF"
   _____ _           _                     _   
  / ____| |         | |                   | |  
 | |    | |__   __ _| |___      _____   __| |_ 
 | |    | '_ \ / _` | __\ \ /\ / / _ \ / _` __|
 | |____| | | | (_| | |_ \ V  V / (_) | (_| |_ 
  \_____|_| |_|\__,_|\__| \_/\_/ \___/ \__,_(_)
                                                
           Deploy Script v1.0
EOF
echo -e "${NC}"

# ========================================
# FUNÇÕES
# ========================================

check_requirements() {
    echo -e "${YELLOW}[1/7] Verificando requisitos...${NC}"
    
    # Verifica Docker
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}❌ Docker não encontrado. Instale: https://docs.docker.com/get-docker/${NC}"
        exit 1
    fi
    
    # Verifica Docker Compose
    if ! command -v docker-compose &> /dev/null; then
        echo -e "${RED}❌ Docker Compose não encontrado.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Docker e Docker Compose instalados${NC}"
}

check_env_file() {
    echo -e "${YELLOW}[2/7] Verificando arquivo .env.production...${NC}"
    
    if [ ! -f .env.production ]; then
        echo -e "${RED}❌ Arquivo .env.production não encontrado!${NC}"
        echo "Copie .env.production.example e configure as variáveis:"
        echo "cp .env.production.example .env.production"
        exit 1
    fi
    
    # Verifica variáveis críticas
    if grep -q "SUBSTITUA" .env.production; then
        echo -e "${RED}❌ Ainda existem valores 'SUBSTITUA' no .env.production${NC}"
        echo "Configure todas as variáveis antes de continuar."
        exit 1
    fi
    
    echo -e "${GREEN}✅ Arquivo .env.production configurado${NC}"
}

generate_secrets() {
    echo -e "${YELLOW}[3/7] Gerando secrets se necessário...${NC}"
    
    # Gera SECRET_KEY_BASE se vazio
    if ! grep -q "SECRET_KEY_BASE=.\{64,\}" .env.production; then
        echo "Gerando SECRET_KEY_BASE..."
        SECRET=$(openssl rand -hex 64)
        sed -i.bak "s/SECRET_KEY_BASE=.*/SECRET_KEY_BASE=$SECRET/" .env.production
        echo -e "${GREEN}✅ SECRET_KEY_BASE gerado${NC}"
    fi
}

pull_images() {
    echo -e "${YELLOW}[4/7] Baixando imagens Docker...${NC}"
    docker-compose -f docker-compose.prod.yml pull
    echo -e "${GREEN}✅ Imagens baixadas${NC}"
}

start_services() {
    echo -e "${YELLOW}[5/7] Iniciando serviços...${NC}"
    docker-compose -f docker-compose.prod.yml up -d
    echo -e "${GREEN}✅ Serviços iniciados${NC}"
}

setup_database() {
    echo -e "${YELLOW}[6/7] Configurando banco de dados...${NC}"
    
    echo "Aguardando serviços ficarem prontos..."
    sleep 10
    
    # Verifica se DB já existe
    if docker-compose -f docker-compose.prod.yml exec -T rails bundle exec rails db:version &> /dev/null; then
        echo "Banco de dados já existe. Executando migrações..."
        docker-compose -f docker-compose.prod.yml exec -T rails bundle exec rails db:migrate
    else
        echo "Criando banco de dados..."
        docker-compose -f docker-compose.prod.yml exec -T rails bundle exec rails db:chatwoot_prepare
    fi
    
    echo -e "${GREEN}✅ Banco de dados configurado${NC}"
}

show_status() {
    echo -e "${YELLOW}[7/7] Status dos serviços:${NC}"
    docker-compose -f docker-compose.prod.yml ps
    
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}✅ Deploy concluído com sucesso!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo "Acesse: http://localhost:3000"
    echo ""
    echo "Comandos úteis:"
    echo "  Ver logs:        docker-compose -f docker-compose.prod.yml logs -f"
    echo "  Parar:           docker-compose -f docker-compose.prod.yml down"
    echo "  Reiniciar:       docker-compose -f docker-compose.prod.yml restart"
    echo "  Console Rails:   docker-compose -f docker-compose.prod.yml exec rails bundle exec rails console"
    echo ""
}

# ========================================
# MENU PRINCIPAL
# ========================================

case "${1:-deploy}" in
    deploy)
        check_requirements
        check_env_file
        generate_secrets
        pull_images
        start_services
        setup_database
        show_status
        ;;
    
    update)
        echo -e "${YELLOW}Atualizando Chatwoot...${NC}"
        docker-compose -f docker-compose.prod.yml pull
        docker-compose -f docker-compose.prod.yml up -d
        docker-compose -f docker-compose.prod.yml exec rails bundle exec rails db:migrate
        echo -e "${GREEN}✅ Atualização concluída${NC}"
        ;;
    
    stop)
        echo -e "${YELLOW}Parando serviços...${NC}"
        docker-compose -f docker-compose.prod.yml down
        echo -e "${GREEN}✅ Serviços parados${NC}"
        ;;
    
    restart)
        echo -e "${YELLOW}Reiniciando serviços...${NC}"
        docker-compose -f docker-compose.prod.yml restart
        echo -e "${GREEN}✅ Serviços reiniciados${NC}"
        ;;
    
    logs)
        docker-compose -f docker-compose.prod.yml logs -f
        ;;
    
    backup)
        echo -e "${YELLOW}Criando backup do banco de dados...${NC}"
        BACKUP_FILE="backup_chatwoot_$(date +%Y%m%d_%H%M%S).sql"
        docker-compose -f docker-compose.prod.yml exec -T postgres pg_dump -U postgres chatwoot_production > "$BACKUP_FILE"
        echo -e "${GREEN}✅ Backup criado: $BACKUP_FILE${NC}"
        ;;
    
    console)
        docker-compose -f docker-compose.prod.yml exec rails bundle exec rails console
        ;;
    
    *)
        echo "Uso: $0 {deploy|update|stop|restart|logs|backup|console}"
        echo ""
        echo "Comandos:"
        echo "  deploy   - Deploy inicial completo"
        echo "  update   - Atualizar para nova versão"
        echo "  stop     - Parar todos os serviços"
        echo "  restart  - Reiniciar serviços"
        echo "  logs     - Ver logs em tempo real"
        echo "  backup   - Backup do banco de dados"
        echo "  console  - Abrir Rails console"
        exit 1
        ;;
esac
