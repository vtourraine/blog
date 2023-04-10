Title:    MiXiT 2023 avec SwiftUI  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     April 10, 2023  
Update:   
Keywords: dev, iOS, macOS  
Summary:  J’avais complètement oublié MiXiT. Ça fait pourtant huit ans que je maintiens mon application, mais cette fois, j’avais oublié.  
Image:    https://www.vtourraine.net/blog/img/2023/mixit-swiftui/mixit-devices.jpg  
Language: fr  


J’avais complètement oublié [MiXiT](https://mixitconf.org/). Ça fait pourtant huit ans que je maintiens [mon application](https://apps.apple.com/app/mixit-conference/id982003173), mais cette fois, j’avais oublié.

Heureusement, j’ai reçu [une pull request](https://github.com/vtourraine/mixit/pull/2) la semaine dernière, me rappelant que MiXiT 2023 a lieu les 13 et 14 avril. Merci Nathan !

Seul problème : j’avais entamé l’année dernière une ré-écriture du projet avec Swift et SwiftUI. [J’en ai parlé sur ce blog](https://www.vtourraine.net/blog/2022/swiftui-mixit), le résultat ne m’a pas convaincu à 100%. Mais il faut savoir aller de l’avant. Pas envie d’attendre encore un an pour passer à Swift(UI). J’ai donc mergé le code, rapatrié les changements pour l’édition 2023, et voilà : la mise à jour est disponible sur l’App Store et le Mac App Store.

![Application MiXiT sur iPad et iPhone](/blog/img/2023/mixit-swiftui/mixit-devices.jpg)

Il manque quelques fonctionnalités par rapport à la version UIKit (intégration du calendrier, consultation des éditions passées), mais je ne désespère pas de rattraper ça plus tard.

Et, pour être tout à fait transparent, dans la précipitation de cette mise à jour de dernière minute, j’avais oublié d’implémenter la sauvegarde du contexte Core Data. Donc : les données étaient re-téléchargées à chaque ouverture, et les favoris ne persistaient pas. [Oops](https://github.com/vtourraine/mixit/commit/bc046ec15208464025241b6b381a8627afe1e388). J’ai publié une seconde mise à jour dans la foulée.

Si vous avez la chance d’assister à MiXiT, mon application est vraiment prête. Retour à CPE cette année, je m’en veux de manquer ça. Peut-être que pour les dix ans de l’application, je proposerai un talk pour parler de ses évolutions. MiXiT 2025, go go go !
