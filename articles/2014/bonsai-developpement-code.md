Title:    La métaphore du bonsai  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     March 28, 2014  
Update:   
Keywords: gestion de projets, projet
Summary:  Tout le monde adore les métaphores, n’est-ce-pas ? Un ordinateur c’est comme une voiture. Ou un camion. Aujourd’hui j’ai l’impression que coder, c’est un peu comme entretenir un bonsai. Certains le considèrent comme du jardinage, d’autres comme un art. Et parfois, on peut ressentir une envie incontrôlable de tout brûler.  
Image:    http://www.vtourraine.net/blog/img/bonsai-developpement-code/cotoneaster.jpg  
Language: fr  
Project:  WizBox  

<p>Tout le monde adore les métaphores, n’est-ce-pas ? Un ordinateur c’est comme une voiture. Ou un camion. Aujourd’hui j’ai l’impression que coder, c’est un peu comme entretenir un bonsai. Certains le considèrent comme du jardinage, d’autres comme un art. Et parfois, on peut ressentir une envie incontrôlable de tout brûler.</p>

<figure class="slideshow">
  <img src="img/bonsai-developpement-code/cotoneaster.jpg" alt="Cotoneaster">
  <figcaption><a href="https://www.flickr.com/photos/openeye/5428831/">“Cotoneaster” by Mike</a>,  © Attribution-ShareAlike License</figcaption>
</figure>

<h2>Lutter contre une croissance incontrôlée</h2>

<p>Lorsqu’on travaille sur un projet, les améliorations les plus évidentes consistent à ajouter du code. Nouvelles fonctions, gestion de cas particuliers, support de différentes configurations, même la correction d’un bug passe souvent par l’ajout d’un nouveau bloc d’instructions. </p>
<p>Cette croissance sans fin apporte malheureusement autant de problèmes qu’elle n’en résout. Concrètement, chaque ligne de code cache un bug potentiel. En ce qui concerne l’expérience utilisateur, chaque nouvelle fonction apporte son lot de confusions. L’accumulation de ces développements conduit à une inertie globale du projet tout en complexifiant son utilisation, et donc en réduisant l’intérêt et la valeur.</p>
<p>Prenons un petit exemple. Tout le monde considère Instagram comme une application “simple”. Facile à utiliser, et forcément facile à développer (je te fais ça en un week-end). <a href="http://parislemon.com/post/74043316441/where-is-this-geotagged-place-wonders-instagram">MG Siegler remarquait</a> qu’à chaque fois qu’il poste une photo, il se trouve toujours quelqu’un pour lui demander “where was this picture taken?”. Le problème, c’est que chaque photo est justement géo-tagguée, merci le GPS de l’iPhone, et que le nom du lieu est même inscrit en toutes lettres au-dessus de chaque entrée, merci les API de <a href="http://en.wikipedia.org/wiki/Reverse_geocoding">reverse geocoding</a>. Voir   l’application ajouter de nouvelles fonctionnalités comme Instagram Direct pour envoyer des photos en privé, avant tout dans un souci de répondre à la concurrence, soulève une certaine inquiétude sur sa stratégie à long terme.</p>

<h2>Un entretien régulier</h2>

<p>Pour en revenir à notre bonsai, il convient donc de se débarrasser régulièrement des branches qui deviennent trop encombrantes. On peut toujours prendre du recul pour mieux apprécier l’étendue d’un projet, et estimer quelles parties sont dispensables. C’est vrai de façon ponctuelle, où certaines fonctions peuvent être réécrites de façon plus concise, et à une échelle plus globale, où des fonctionnalités deviennent redondantes et peuvent être remplacées avantageusement.</p>
<p>J’ai ressorti le mois dernier <a href="http://www.studioamanga.com/wizbox/">un projet iOS</a> que j’avais entamé en 2009, et qui n’avait pas été modifié depuis 2011. Au delà de ce qu’on peut objectivement qualifier d’erreurs, souvent liées à une mauvaise compréhension du langage et des frameworks, le développement iOS s’est tout simplement amélioré depuis, et il convient de faire évoluer son code en conséquence. J’utilisais uniquement des <code>ivars</code>, je peux maintenant utiliser des <code>properties</code>. Ma gestion de la mémoire était... hésitante, longue vie à ARC. Autant de changements qui demandent du travail, mais qui me paraissent incontournables aujourd’hui avant de pouvoir envisager de toucher aux fonctionnalités elles-mêmes et améliorer l’expérience utilisateur.</p>
<p>Le plus difficile est de choisir d’enlever quelque chose sans chercher à le remplacer. Une application ne devrait pas être une accumulation pure et simple de fonctionnalités. Il faut savoir la faire évoluer, et accepter de perdre certaines choses pour en gagner d’autres. Il y aura toujours une raison de conserver l’existant, mais ce sont autant d’entraves à la qualité du projet sur le long terme.</p>
