# Configurando Alias para Comandos GIT

No dia a dia como desenvolvedor, é comum utilizar comandos repetitivos. Para facilitar a vida e melhorar a produtividade, é possível criar alias para os comandos mais utilizados.

## Alias

Para criar um alias, basta adicionar a seguinte linha no arquivo global de configuração do GIT. A seguir, um exemplo de alguns alias que utilizo:

```bash
$ git config --global -e

  (...)
  [alias]
    co = !git checkout
    s = !git status -s
    c = !git add --all && git commit -m
    l = !git log --pretty=format:'%C(blue)%h%C(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr'
    ll = !git log --pretty=format:'%C(blue)%h%C(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr' --graph
  (...)
```