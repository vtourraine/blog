Title:     Un mode nuit pour Air Grenoble  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      May 23, 2019  
Update:     
Keywords:  iOS, app, dev  
Summary:   De nombreuses applications iOS proposent un mode sombre. macOS propose un mode sombre, et une API pour les applications qui veulent l’adopter. Tout porte à croire qu’iOS 13, quand il sera présenté le mois prochain, proposera un mode sombre. Le mode sombre est à la mode.  
Image:     https://www.vtourraine.net/blog/img/2019/air-grenoble-mode-nuit/air-grenoble-day-night.png  
Language:  fr  


De nombreuses applications iOS proposent un mode sombre. macOS propose un mode sombre, et une API pour les applications qui veulent l’adopter. Tout porte à croire qu’iOS 13, quand il sera présenté le mois prochain, proposera un mode sombre. Le mode sombre est à la mode.

(Le gros problème des applications iOS qui proposent un mode sombre aujourd’hui, c’est qu’elles ont chacune [un mécanisme différent](https://www.vtourraine.net/blog/img/2019/air-grenoble-mode-nuit/dark-modes.png), souvent un mélange de bouton dans les réglages et de détection de la luminosité de l’écran, avec parfois un geste à plusieurs doigts comme raccourci. Vivement qu’iOS 13 uniformise tout ça.)

Et donc, la nouvelle version d’[Air Grenoble](https://itunes.apple.com/app/air-grenoble/id1183533416?mt=8) propose… un mode nuit. Attention, pas un mode _sombre_. Un mode _nuit_.

![Mode jour et mode nuit, Air Grenoble](/blog/img/2019/air-grenoble-mode-nuit/air-grenoble-day-night.png)

Ce n’est pas révolutionnaire pour une application de type « météo », mais ça s’intègre tout naturellement au fonctionnement et à l’apparence déjà existants. **Par défaut, en journée, le fond est bleu ciel. La nuit, le fond passe en bleu foncé.** Pas besoin d’ajouter un réglage, tout se fait automatiquement. Ça paraît tellement évident que j’aurais dû y penser dès la première version de l’application, mais voilà, mieux vaut tard que jamais.

Concrètement, l’adaptation de l’interface consiste à changer le `backgroundColor` de la vue principale, mais aussi à actualiser les contours des labels et du badge coloré de l’indice principal en haut de l’écran (ils ont un contour de la couleur du fond, pour améliorer leur lisibilité quand un nuage passe derrière).

Autre détail d’implémentation : comment déterminer l’heure de lever et de coucher du soleil ? Foundation n’offre pas cette information, je ne veux pas faire appel à un web service, et je préfère éviter une bibliothèque tierce trop complexe. J’utilise finalement l’algorithme le plus simple possible : je compare l’heure avec des constantes. Aujourd’hui à Grenoble, le lever est prévu à 5:58 et le coucher à 21:06. Côté code, je simplifie, avec la journée qui commence à 6 heures et se termine à 21 heures.

``` swift
enum Appearance {
  case day
  case night
}

func currentAppearance() -> Appearance {
  let calendar = Calendar.current
  let DefaultAppearance = Appearance.day
  let SunriseHour = 6
  let SunsetHour = 21

  guard let timeZone = TimeZone(identifier: "Europe/Paris"), let hour = calendar.dateComponents(in: timeZone, from: Date()).hour else {
    return DefaultAppearance
  }

  if (hour < SunriseHour || hour >= SunsetHour) {
    return .night
  }
  else {
    return .day
  }
}
```

Notez que je précise explicitement le fuseau horaire, afin de toujours refléter l’état du jour et de la nuit pour Grenoble, même si l’horloge de l’appareil est configurée différemment. Je suppose que la plupart des personnes qui utilisent cette application se trouvent à Grenoble, mais si vous testez depuis l’autre bout du monde (par exemple pour l’équipe de validation de l’App Store, peut-être ?), Air Grenoble suivra bien l’heure de Grenoble, pas de votre lieu actuel. Ça me semble logique.

Cette approche ultra-simple est satisfaisante pour l’instant, mais il faudra tout de même prendre en compte l’évolution des heures de lever et coucher du soleil au fil de l’année. Solution #1 : pour chaque mise à jour de l’application, j’actualise ces constantes. Ça fonctionnerait plutôt bien si les mises à jour étaient fréquentes. Solution #2 : utiliser un ensemble de constantes en fonction du mois. Le résultat serait toujours très approximatif (par exemple, avec une rupture au passage à l’heure d’été), mais au moins le système fonctionnerait en totale indépendance sur toute l’année. Je pense donc préparer ça pour une prochaine version.

Comme vous pouvez le constater, l’objectif de cette fonctionnalité n’est pas de fournir une précision astronomique, simplement d’égayer un peu l’apparence de cette application, pour un écran qui a vocation à être consulté tous les matins. D’abord avec [des nuages qui flottent](https://www.vtourraine.net/blog/2018/air-grenoble-2-clouds-view), maintenant avec une vue nocturne.

En bonus, cet ajout prépare le terrain pour l’arrivée d’un mode sombre officiel. Il faudra ajuster tout ça une fois que les détails seront connus, mais a priori, j’imagine la future implémentation comme suit : le fond nuit apparaîtra si c’est effectivement la nuit ou si le mode sombre est activé, sinon, on reste en bleu ciel. Ça ne devrait pas être trop compliqué à mettre en place.
