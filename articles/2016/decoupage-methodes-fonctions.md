# Découpage des méthodes

Comment découper son code en méthodes/fonctions ? Quel est le bon moment pour choisir d’écrire une nouvelle méthode, plutôt que de simplement continuer avec celle déjà existante ? 

Ces questions sont terriblement basiques, mais je continue de me les poser continuellement. 

Il n’existe évidemment pas de réponse simple et définitive, alors comme souvent, on a tendance à se reposer sur des bonnes pratiques, et autres [règles de pouces](https://en.wikipedia.org/wiki/Rule_of_thumb).

Je me souviens notamment d’une approche conseillant de copier-coller un bloc de code une fois, pour ensuite créer une nouvelle fonction à partir de la troisième occurrence du code (à la place d’un second copier-coller, donc). À l’opposé, on trouve des recommandations beaucoup plus strictes, incitant notamment à limiter les fonctions à une dizaine de ligne au maximum, pour les forcer à leur plus simple expression, en interdisant la moindre duplication de code.

Globalement, j’ai de plus en plus tendance à préférer l’approche restrictive. Ce n’est certainement pas une révélation, et encore une fois, il ne s’agit pas de consignes absolues. Mais je connais ma tendance à écrire un code continu toujours trop long, et cette règle est une bonne consigne pour m’aider à structure mon code de façon plus claire. Car c’est bien de cela qu’il est question. Écrire un code simple et explicite, autant que possible. Pour les autres, et pour soi-même. Pour un code plus facile à tester, et pour limiter les bugs.

Voici donc quelques recommandations :

- Limiter les fonctions à une dizaine de lignes
- Limiter les fonctions à deux niveaux de blocs (pas de `if`/`for` imbriqués)
- Limiter les fonctions à un seul niveau d’abstraction
- Pas de copier-coller

Tout cela peut paraître évident, ou horriblement contraignant. On trouve souvent ce genre de consignes pour des exercices de programmation, lors de [code retreat](http://coderetreat.org) par exemple. Je trouve utile de garder ces recommandations en tête, pour les appliquer autant que possible. 