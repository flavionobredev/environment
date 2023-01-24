# Chave SSH para GIT

A chave SSH é uma das formas de autenticação mais seguras para o GIT. Ela é utilizada para autenticar o usuário no repositório remoto.

Para gerar uma chave SSH, siga os passos abaixo:

## 1. Gere uma chave SSH

```bash
$ mkdir -p ~/.ssh
$ cd ~/.ssh
$ ssh-keygen -t ed25519 -C "chave ssh para git"
```

Irá aparecer a seguinte mensagem:

```bash
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/flavio/.ssh/id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

Digite o caminho para salvar a chave, caso queira manter o padrão, apenas pressione enter. Em seguida, digite a senha para a chave. Caso não queira utilizar senha, apenas pressione enter.

## 2. Copie o conteúdo da chave pública

```bash
$ cat ~/.ssh/id_ed25519.pub
```

## 3. Adicione a chave no servidor GIT remoto

No Github, vá em `Settings > SSH and GPG keys > New SSH key` e cole o conteúdo da chave pública.

No Gitlab, vá em `Settings > SSH Keys > Add SSH key` e cole o conteúdo da chave pública.

## 4. Adicionando arquivo `config`

Na pasta `.ssh` crie um arquivo chamado `config` e adicione o seguinte conteúdo:

```bash
Host gitlab.company.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_ed25519
```

É possível adicionar mais de um host no caso de múltiplas contas. Basta adicionar um novo bloco de configuração.

## 5. (Opcional) Produtividade com SSH

- **Solicitar senha apenas uma vez**
  
  Ao utilizar a chave ssh é solicitado a senha toda vez que é feito um push ou pull. Para evitar isso, é possível utilizar o comando abaixo:
  
  ```bash
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  ```

  Isso fará com que a senha seja solicitada apenas uma vez e o ssh-agent irá armazenar a chave em memória, durante a sessão daquele shell.

  Existe outra maneira de garantir que solicitará apenas uma vez: na inicialização do sistema. Para isso, vamos adicionar algumas linhas ao arquivo `~/.bash_profile`:

  ```bash
  # SSH
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  ```