#!/bin/bash
# script de backup para portainer de produção da service-api-1

# configurando awscli para S3
HAS_AWS_S3_CONFIG=$(aws configure get aws_access_key_id --profile=s3-automation | wc -l)

if [ $HAS_AWS_S3_CONFIG -eq 0 ]; then
    aws configure --profile s3-automation
fi

# gerando backup do portainer local
FILENAME="<SCOPE_HERE>-portainer-backup.tar.gz"
API_TOKEN="USER_ADMIN_TOKEN_GENERATED_IN_PORTAINER"

curl --request POST \
  --url http://localhost:80/api/backup \
  --header 'X-API-Key: '"${API_TOKEN}"'' \
  --header 'Content-Type: application/json' \
  --data '{"password":"service-api-1"}' > /tmp/$FILENAME

# mover backup para s3
aws s3 cp /tmp/$FILENAME s3://service-api-1/portainer-bkp/ --profile s3-automation

# remover backup local
rm -rf /tmp/$FILENAME

# log
echo "Backup realizado com sucesso em $(date)"