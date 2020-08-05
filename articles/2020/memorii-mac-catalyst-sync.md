Title:     Memorii pour Mac avec synchronisation iCloud  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      August 5, 2020  
Update:    
Keywords:  dev, macOS, iOS  
Summary:   Memorii est maintenant disponible sur le Mac App Store, avec synchronisation iCloud des données entre iPhone, iPad et Mac.  
Image:     https://www.vtourraine.net/blog/img/2020/memorii-mac-catalyst-sync/memorii-macbook-pro.png  
Language:  fr  


Memorii est maintenant [disponible sur le Mac App Store](https://apps.apple.com/app/memorii/id352411168).

![Memorii pour Mac](/blog/img/2020/memorii-mac-catalyst-sync/memorii-macbook-pro.png)

L’interface ne laisse pas de doutes : il s’agit de l’application iOS, portée sur le Mac avec Catalyst. La tab bar paraît étrangère, et les listes en pleine largeur sont mal adaptées aux grands écrans.

Mais il faut reconnaître que Catalyst remplit son contrat. Une case cochée dans Xcode, et le résultat est fonctionnel, à défaut d’être satisfaisant. La nouvelle split view avec trois colonnes améliorerait sensiblement l’interface sur iPad et sur Mac, mais il faudra attendre encore un peu pour abandonner le support d’iOS 13/macOS 10.15.

Et pour profiter de cette plateforme supplémentaire, la mise à jour apporte une fonctionnalité longtemps attendue : la synchronisation iCloud. Un utilisateur peut désormais retrouver ses dossiers et ses listes de vocabulaire sur tous ses appareils.

Je n’avais ni le temps ni les resources pour implémenter un service de synchronisation sur mesure. Heureusement, iOS 13 a apporté une nouvelle API pour connecter Core Data à CloudKit. Une API un peu magique, avec une seule classe à changer pour bénéficier d’une synchronisation complètement automatique. `NSPersistentCloudKitContainer`. Ça paraît trop beau pour être vrai, surtout après les échecs passés des API iCloud pour Core Data. Mais après presque une année en service, les retours d’autres développeurs sont positifs. Pour Memorii, il est trop tôt pour tirer un bilan de cette technologie, mais les débuts sont prometteurs.

Il y a bien un problème qui m’avait échappé avant de déployer cette mise à jour : les données présentes *avant* la mise à jour sont ignorées par iCloud. Elles ne disparaissent pas, mais elles ne sont pas poussées vers les autres appareils. Pour y remédier, il faut éditer chaque objet individuellement. Ce n’est pourtant pas un bug à proprement parler. Si je comprends bien, il s’agit d’éviter des duplications de données, puisqu’iCloud ne sait pas réconcilier un même objet existant sur plusieurs appareils. Dommage que la documentation ne mentionne pas ce problème. À l’avenir, il faudrait donc implémenter une migration sur mesure pour y remédier, ou accepter que des données apparaissent en double.

Je vais maintenant pouvoir m’intéresser à certaines de mes autres applications, qui pourraient également bénéficier d’une version Mac et de la synchronisation iCloud.
