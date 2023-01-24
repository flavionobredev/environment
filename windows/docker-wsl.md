# Docker para WSL2

Configurar ambientes de desenvolvimento no Windows sempre foi burocrático e complexo, além do desempenho de algumas ferramentas não serem totalmente satisfatórias.

Com o nascimento do Docker este cenário melhorou bastante, pois podemos montar nosso ambiente de desenvolvimento baseado em Unix, de forma independente e rápida, e ainda unificada com outros sistemas operacionais.

Todas as nossas aplicações em desenvolvimento rodam em containers `docker`, orquestrados com `docker compose`. 

## Instalação do Docker no WSL2

> Importante: recomendamos fortemente a instalação do docker-engine (tutorial a seguir) ao invés do docker desktop.

### 1. Desinstale versões anteriores do Docker

Versões anteriores do Docker podem sujar a nova instalação. Para remover, execute o comando abaixo:

```bash
$ sudo apt-get remove docker docker-engine docker.io containerd runc
```

### 2. Atualize os pacotes e instale os pré-requisitos

```bash
$ sudo apt-get update
$ sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

### 3. Adicione a chave GPG oficial do Docker

```bash
$ sudo mkdir -p /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

### 4. Adicione o repositório do Docker

```bash
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### 5. Atualize os pacotes e instale o Docker Engine

```bash
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```
A partir daqui o Docker já está instalado. Seguiremos com o pós instalação.

## Pós instalação

### 1. Adicione o seu usuário ao grupo `docker`

```bash
$ sudo usermod -aG docker $USER
```
### 2. Reinicie o WSL

No Windows, abra o PowerShell e execute o comando abaixo:

```bash
$ wsl --shutdown
```

### 3. Teste a instalação

Para utilizar o Docker no WSL2 é necessário iniciar seu serviço antes de executar os comandos. Para isso, execute o comando abaixo:

```bash
$ sudo service docker start
```

Com isso, o serviço do Docker já está rodando. Para testar a instação, execute o comando abaixo:

```bash
$ docker run hello-world
```

## Dicas e truques

### Criando alias para iniciar serviço Docker

Como podemos perceber, para utilizar o Docker no WSL2 é necessário iniciar seu serviço antes de executar os comandos.

Esse comportamento, no primeiro momento, pode ser incoveniente. Mesmo assim, há maneiras de fazer o Docker iniciar automaticamente.

Contudo, com experiência, percebemos que é mais fácil iniciar o serviço manualmente, pois assim **podemos controlar quando o serviço será iniciado**: às vezes, ao abrir o Linux, não precisamos que o serviço Docker esteja ativo e consumindo recursos de forma desnecessária.

Para facilitar, podemos criar um alias para executar o comando `sudo service docker start` sempre que o comando `docker` for executado.

Para isso, abra o arquivo `~/.bashrc` e adicione o seguinte conteúdo:

```bash
alias dockerstart='sudo service docker start'
```
Após adicionar o conteúdo, salve o arquivo e feche-o. Atualize o shell com as informações novas com o comando:

```bash
$ source ~/.bashrc
```

Agora, sempre que executarmos o comando `dockerstart`, o serviço do Docker será iniciado automaticamente.

> **Dica**: se você utiliza o `zsh`, adicione o conteúdo acima no arquivo `~/.zshrc`. Caso contrário, adicione no arquivo `~/.bashrc`.

### Resolvendo problemas internet com Docker

Pode acontecer situações em que o Docker não consiga acessar a internet. Isso pode acontecer por diversos motivos, mas o mais comum é por conta da configuração de rede do WSL2.

Ao iniciar o WSL, criam-se as interfaces de rede do Host (linux no WSL). Por padrão, o WSL2 utiliza a interface `eth0` para se comunicar com o Host. O Docker, por sua vez, utiliza a interface `docker0` para se comunicar com a internet. Existem situações em que o ip/máscara da interface `eth0` utiliza a mesma classe de rede da interface `docker0` (172.17.xxx.xxx), o que pode causar problemas de comunicação.

Para resolver esse problema, basta adicionar a seguinte configuração no arquivo `/etc/docker/daemon.json`:

```json
{
  "bip": "172.17.0.1/28"
}
```

Após adicionar o conteúdo, salve o arquivo e feche-o. Execute o comando para reiniciar o WSL2:

```bash
$ wsl --shutdown
```
Pronto! Agora o Docker já pode se comunicar com a internet.

> Obs: se o arquivo `/etc/docker/daemon.json` não existir, crie-o. Não tem problema.