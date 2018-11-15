set -a
ENV="${1:-dev}"
source ./env/${ENV}.env
set +a

echo "Loading $ENV environment..."
