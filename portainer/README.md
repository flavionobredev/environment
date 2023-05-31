# Portainer

Portainer é um gerenciador de containers Docker. Link para a documentação oficial: [https://docs.portainer.io/](https://docs.portainer.io/)

## Instalação no Docker

Para instalar o portainer no docker, execute o comando abaixo:

```bash
docker run -d \
   -p 8000:8000 \
   -p 443:9443 \
   -p 9000:9000 \
   --name portainer \
   --restart=always \
   -v /var/run/docker.sock:/var/run/docker.sock \
   -v portainer_data:/data \
   portainer/portainer-ce:2.18.3
```

## Backup do Portainer

### Configuração

1. Rode o script [portainer-backup.sh](portainer-backup.sh) para gerar o arquivo de backup inicial.
2. Será solicitado as credenciais da AWS de um usuário com acesso ao S3.
   1. aws_access_key_id e;
   2. aws_secret_access_key.
3. Gere um token no portainer, com um usuário admin, para ser utilizado no backup. Acesse: <ip_ou_dns_portainer>/#!/account/tokens/new
4. Configure as variáveis dentro do script [portainer-backup.sh](portainer-backup.sh) de acordo com o seu ambiente. Mais informações sobre as variáveis abaixo.

### Adicionando script e criando cron

1. Adicione o script de backup no servidor onde o portainer está instalado.
2. Crie uma entrada no cron para executar o script de backup diariamente. Exemplo:

```bash
@daily /bin/bash /home/ec2-user/portainer-backup.sh
```

### Variáveis

| Variável                                | Descrição                                                                                           |
| --------------------------------------- | --------------------------------------------------------------------------------------------------- |
| SCOPE_HERE                              | Escopo do portainer. Por exemplo: service-api-1                                                     |
| USER_ADMIN_TOKEN_GENERATED_IN_PORTAINER | Token gerado no portainer para o usuário admin. Acesse: <ip_ou_dns_portainer>/#!/account/tokens/new |

> nota: a senha para utilizar o backup é `service-api-1`
