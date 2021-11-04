---
title: "Como saber por quanto tempo um processo está sendo executado?"
date: 2021-11-04T00:17:15-03:00
draft: false
author: "Carlos Adean"
tags: ["sysadmin", "linux","bash"]
categories: ["sysadmin", "linux"]
slug: "como-saber-por-quanto-tempo-um-processo-está-sendo-executado"
---

### Como possso saber por quanto tempo um processo ou PID está sendo executado em um sistema Linux?

Você precisa usar o comando `ps` para ver as informaçõese sobre os processo ativos. 

O comando `ps` possui as seguintes opções de formatação:

`etime:` exibe o tempo decorrido desde que o processo foi iniciado, no formato [[DD-]hh:]mm:ss.

`etimes:` exibe em segundos o tempo decorrido desde que o processo foi iniciado.


### Como verificar por quanto tempo um processo está sendo executado?

Você precisa informar o parâmetro `-o etimes` ou `-o etime` para o comando `ps`. A sintaxe é a seguinte:

```console
ps -p [PID] -o etimeps -p [PID] -o etimes
```

### Etapa 1: Procurar o PID e um processo (ex: evince)

```console
$ pidof evince
7625
```

### Etapa 2: Por quanto tempo o processo do evince está sendo executado?

```console
$ ps -p 7625 -o etime
```
ou

```console
$ ps -p 7625 -o etimes
```

Para esconder o cabeçalho, você pode executar:

```console
$ ps -p 7625 -o etime=$ ps -p 7625 -o etimes=
```

Alguns exemplos de saída dos comandos acima:

```console
[cas@home ~]$ pidof evince
7625 6883
[cas@home ~]$ ps -p 7625 -o etime
    ELAPSED
      48:39
[cas@home ~]$ ps -p 7625 -o etime=
      48:43
[cas@home ~]$ ps -p 7625 -o etimes
ELAPSED
   2929
[cas@home ~]$ ps -p 7625 -o etimes=
   2932
[cas@home ~]$ ps -p 7625 -o pid,cmd,etime,uid,gid
  PID CMD                             ELAPSED   UID   GID
 7625 evince /home/cas/Do       49:25  1000  1000
 ```

O número 7625 é o PID do processo que queremos verificar, neste exemplo checamos o processo do evince, leitor pdf do Gnome. Já no exemplo abaixo estou exibindo o PID, o comando, o tempo, o ID do usuário e o ID do grupo:

```console
[cas@home ~]$ ps -p 7625 -o pid,cmd,etime,uid,gid
  PID CMD                             ELAPSED   UID   GID
 7625 evince /home/cas/Do       49:25  1000  1000
```