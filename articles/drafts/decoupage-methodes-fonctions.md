# Découpage des méthodes

Comment découper son code en méthodes/fonctions ? Quel est le bon moment pour choisir d’écrire une nouvelle méthode, plutôt que de simplement continuer avec celle déjà existante ? 

Ce genre de questions est terriblement basique, mais je continue de me les poser continuellement. 

Il n’existe évidemment pas de réponse simple et définitive, alors comme souvent, j’ai tendance à me reposer sur des bonnes pratiques, et autres [règles de pouces](https://en.wikipedia.org/wiki/Rule_of_thumb).

Je me souviens notamment d’un conseil établissant qu’il est convenable de copier-coller un bloc de code une fois, mais qu’il faut créer une nouvelle fonction à partir de la troisième occurrence du code (à la place d’un second copier-coller, donc). À l’opposé, on trouve des approches beaucoup plus strictes, incitant notamment à limiter les fonctions à une dizaine de ligne au maximum, pour les forcer à leur plus simple expression.

Globalement, j’ai de plus en plus tendance à préférer l’approche stricte. Ce n’est certainement pas une révélation, et encore une fois, il ne s’agit pas de consignes absolues. Mais je connais ma tendance à écrire un code continu toujours trop long, et cette règle est une bonne consigne pour m’aider à structure mon code de façon plus claire. Car c’est bien de cela qu’il est question. Écrire un code simple et explicite, autant que possible.