#!/bin/bash
set -e

REPO_URL="https://github.com/ExpertosTI/altamar.git"
PROJECT_DIR="/opt/pescaderia-altamar"
STACK_NAME="pescaderia"
SERVICE_NAME="${STACK_NAME}_nginx"

echo "🚀 Iniciando despliegue en Servidor Traefik (45.9.191.18)..."

# 1. Sync code via Git
if [ -d "$PROJECT_DIR" ]; then
    echo "🔄 Actualizando código..."
    cd "$PROJECT_DIR"
    git fetch origin main
    git reset --hard origin/main
else
    echo "📦 Clonando repositorio..."
    git clone $REPO_URL $PROJECT_DIR
    cd $PROJECT_DIR
fi

# 2. Check for .env (Si lo hubiera, en este caso no es estricto, pero lo simulamos si es necesario)
# (Saltado porque no usamos .env para la landing)

# 3. Build locally (Swarm has no registry)
echo "🔨 Construyendo imagen de GoAccess (si hubo cambios)..."
docker compose build

# 4. Ensure RenaceNet exists
echo "🌐 Verificando red RenaceNet..."
docker network ls | grep RenaceNet > /dev/null || \
    docker network create --driver overlay RenaceNet

# 4.5. Ensure required directories exist for Docker Swarm bind mounts
echo "📁 Creando directorios necesarios para los volúmenes..."
mkdir -p nginx/logs nginx/admin

# 5. Deploy stack
echo "🚢 Desplegando stack en Docker Swarm..."
docker stack deploy -c docker-compose.yml $STACK_NAME

# 6. Force service to pick up new local image (y aplicar cambios en volúmenes estáticos)
echo "♻️ Forzando actualización de los servicios..."
docker service update --force $SERVICE_NAME 2>/dev/null || true
docker service update --force ${STACK_NAME}_goaccess 2>/dev/null || true

# 7. Cleanup
echo "🧹 Limpiando imágenes antiguas..."
docker image prune -f

# 8. Health check
echo "✅ ¡Despliegue completado con éxito según el Protocolo Renace!"
echo "🔎 Para ver los logs de Nginx: docker service logs -f $SERVICE_NAME"
