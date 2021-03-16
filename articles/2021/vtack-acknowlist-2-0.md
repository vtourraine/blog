Title:    VTAck’ + AcknowList 2.0  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     March 16, 2021  
Update:   
Keywords: dev, iOS  
Summary:  J’ai commencé à travailler sur VTAcknowledgementsViewController pendant mes vacances de fin d’année 2013. Cette semaine, je viens de publier sa version 2.0.  
Image:    https://www.vtourraine.net/blog/img/2021/vtack-acknowlist-2-0/acknowlist-screens.jpg  
Language: fr  


J’ai commencé à travailler sur *VTAcknowledgementsViewController* pendant mes vacances de fin d’année 2013. [Le premier commit](https://github.com/vtourraine/VTAcknowledgementsViewController/commit/aa10ff6ffd4ad1ea23446adddc86afb5705af8bf) date du 24 décembre. Mon principal regret est de ne pas avoir choisi un nom plus facile à écrire (encore aujourd’hui, je copie-colle toujours le nom pour éviter les typos, ou alors je raccourcis en « VTAck »). C’est un projet simple, qui décode un fichier et affiche son contenu. L’idée était de donner un peu de visibilité aux projets open source qui font fonctionner nos applications mobiles.

![Screenshots AcknowList](/blog/img/2021/vtack-acknowlist-2-0/acknowlist-screens.jpg)

**Cette semaine, je viens de publier sa version 2.0.** Pas seulement pour [VTAcknowledgementsViewController](https://github.com/vtourraine/VTAcknowledgementsViewController/releases/tag/2.0.0), mais aussi pour [AcknowList](https://github.com/vtourraine/AcknowList/releases/tag/2.0.0), un projet lancé en 2015 pour ré-implémenter les mêmes fonctionnalités en Swift (avec un nom plus court !). Et, rétrospectivement, le projet n’a pas beaucoup changé. L’interface est restée la même et l’extraction des informations du ficher plist est identique. Ça ne veut pas dire qu’il n’y a pas eu d’améliorations. Les labels ont été traduits dans une dizaine de langues, les écrans supportent pleinement les réglages d’accessibilité, le mode sombre, tout est redimensionnable et dynamique, etc.

Ces projets connaissent un certain succès, avec un peu plus de 1000 étoiles combinées sur GitHub. Rien d’extraordinaire, mais ça reste mon projet le plus populaire. C’est toujours un grand plaisir de télécharger une application pour une raison quelconque, pour ensuite y découvrir une de mes bibliothèques.

Ce passage à la version 2.0 m’autorise surtout à faire du ménage, cassant un peu la rétro-compatibilité, pour éliminer des méthodes superflues et renommer des appellations maladroites. Il y a également quelques améliorations, avec la détection automatique des liens dans les en-têtes et pieds de page (merci `NSDataDetector`), et le choix du style de table view.

Et maintenant ? Ces projets fonctionnent, et n’ont pas spécialement besoin d’évolutions. Tout d’abord, je crois qu’il sera bientôt temps de passer VTack’ en mode maintenance, pour concentrer les efforts sur AcknowList. Maintenir les deux bibliothèques en parallèle est une contrainte que je me suis imposé, mais qui se justifie de moins en moins. La prochaine étape logique serait de proposer une nouvelle implémentation avec SwiftUI. J’ai longtemps envisagé une version AppKit, mais il serait sans doute plus judicieux de s’intéresser au framework de la décennie à venir. Pour SwiftUI, je me demande s’il faudrait un nouveau projet, ou simplement l’ajouter à AcknowList comme une interface alternative ? Devrais-je adapter le modèle pour Combine ? Ou carrément passer à ARKit pour proposer une version en réalité augmentée ?
