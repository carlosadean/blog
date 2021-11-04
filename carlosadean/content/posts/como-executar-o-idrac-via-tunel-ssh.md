---
title: "Como redirecionar o console remoto do iDRAC via tunel SSH"
date: 2021-11-03T20:33:07-03:00
draft: true
author: "Carlos Adean"
tags: ["ssh", "idrac"]
categories: ["sysadmin", "network"]
slug: "como-direcionar-o-console-remoto-do-idrac-via-tunel-ssh"
---



Esses dias precisei acessar um servidor Dell via SSH e ao tentar executar o visualizador remoto *viewer.jnlp*, que está disponível na interface do iDRAC, a conexão com o servidor era dropada e o app fechado.

A seguinte mensagem era apresentada: *the connection has been dropped* pelo icedtea.


A solução eu encontrei nesse [post](https://www.ducea.com/2008/08/20/drac-console-redirection-over-a-ssh-tunnel/) e é a seguinte:

```console
ssh -L 443:ip_do_idrac:443 -L 5900:ip_do_idrac:5900 -L 5901:ip_do_idrac:5901 -l <username> -N host_remoto
```

Um ponto negativo sobre o acesso acima obviamente é que só será possível abrir acessar um servidor por vez, caso você precise acessar mais de um.