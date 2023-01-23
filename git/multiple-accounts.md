# Múltiplas contas no GIT

É possível utilizar o GIT com múltiplas contas, por exemplo, se você trabalha em uma empresa e possui um repositório privado, e também possui um repositório privado para projetos pessoais, você pode configurar o GIT para utilizar as duas contas. Dessa forma, é possível configurar também o SSH e GPG key para utilizar as duas contas.

## Configurando `.gitconfig` para uma conta

Primeiramente, precisamos configurar um arquivo de configuração específico para uma determinada conta. Para isso, execute o comando abaixo:

```bash
cd ~/developer/roots
echo << EOF > .gitconfig
[credential]
  helper = store
[user]
  signingkey = <id_chave_gpg>
  email = email@email.com
  name = Flávio Nobre
[commit]
  gpgsign = true
[gpg]
  program = gpg
EOF
```
Com isso, o arquivo `.gitconfig` será criado na pasta `~/developer/roots`. Agora, precisamos configurar o GIT para utilizar esse arquivo de configuração.

## Configurando GIT global para utilizar arquivos `.gitconfig` específicos

Para isso, execute o comando abaixo:

```bash
git config --global -e
```

Com isso, o arquivo de configuração global do GIT será aberto. Adicione o seguinte conteúdo:

```bash
[includeIf "gitdir:~/developer/roots/**"]
  path = ~/developer/roots/.gitconfig
```

Com isso, o GIT irá utilizar o arquivo `.gitconfig` criado anteriormente, caso o repositório esteja dentro da pasta `~/developer/roots/**`.

Existem outras formas de configurar regras para utilizar arquivos específicos. Consulte em [Includes: Git Configuration](https://git-scm.com/docs/git-config#_includes).