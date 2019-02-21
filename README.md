C'est une version docker de l'excellente application (cheky.net)[https://github.com/Blount/Cheky] qui permet d'avoir des alerte pour le site (leboncoin.fr)[https://leboncoin.fr]

Le container ne contient pas de processus root ce qui augmente la sécurité. Un script se lance toutes les 60sec pour verifier la présence d'alerte
(si vous ajouter la variable --user le container ne pourra pas mettre a jour l'application)

```shell
docker run --name cheky \
  -p 80:8080 \
  -v cheky:/config \
  obyy/cheky:latest
```
