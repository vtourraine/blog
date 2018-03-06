Title:     Tester plusieurs versions d’iOS avec buddybuild  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      May 30, 2017  
Update:    March 6, 2018  
Keywords:  iOS, Xcode, dev  
Summary:   Dès qu’une nouvelle version d’iOS arrive, on aimerait pouvoir abandonner les précédentes. D’une part, pour bénéficier des dernières APIs, mais aussi pour simplifier les conditions d’exécution du code. Or, avec un peu de pragmatisme, il convient généralement de supporter une ou deux versions antérieures afin de ne pas exclure une partie des utilisateurs potentiels.  
Image:     https://www.vtourraine.net/blog/img/2017/tester-ios-buddybuild/buddybuild-configuration-1.png  
Language:  fr  


> ⚠️ **Mise à jour, mars 2018**
> 
> Depuis la publication de cet article, [buddybuild a été racheté par Apple](https://www.buddybuild.com/blog/buddybuild-is-now-part-of-apple). En conséquence, l’offre gratuite de buddybuild n’est plus disponible. À moins de disposer d’un compte buddybuild payant _avant_ l’annonce du rachat, il n’est donc plus possible de mettre en pratique les recommandations de l’article ci-dessous.
> 
> C’est bien dommage, mais cela nous laisse espérer que ces fonctionnalités seront peut-être un jour offertes par Apple.


Dès qu’une nouvelle version d’iOS arrive, on aimerait pouvoir abandonner les précédentes. D’une part, pour bénéficier des dernières APIs, mais aussi pour simplifier les conditions d’exécution du code. Or, avec un peu de pragmatisme, il convient généralement de supporter une ou deux versions antérieures afin de ne pas exclure une partie des utilisateurs potentiels.

Pour développer et tester mes applications, j’utilise avant tout le Simulateur intégré à Xcode, avec la dernière version d’iOS disponible. C’est d’ailleurs la configuration proposée par défaut. Ce qui nous amène à un problème fondamental : **comment s’assurer qu’une application reste compatible avec les versions précédentes ?**

Idéalement, un développeur dispose d’un ensemble d’appareils avec différentes configurations, mais ce genre de dispositif demande des moyens hors de portée pour la plupart d’entre nous. Pire, le compilateur ne vérifie pas si votre code est compatible avec la « deployment target » (pour détecter l’utilisation d’une API trop récente, par exemple). On peut installer différentes versions du Simulateur avec Xcode, et tester manuellement, mais il est trop facile d’oublier ces vérifications.

Il n’existe qu’une seule bonne solution : **automatiser les tests**.

Hélas, la gestion d’un serveur d’intégration continue (a.k.a. le _CI server_) est toujours problématique avec iOS. La bonne nouvelle, c’est qu’un service comme [buddybuild](https://www.buddybuild.com/) peut s’en occuper très simplement.

1. Si ce n’est pas déjà fait, ajoutez une target de test à votre projet Xcode.
2. Ajoutez un simple test, par exemple : `XCTAssertNotNil([UIApplication sharedApplication]);`.
3. Inscrivez-vous (gratuitement) sur [buddybuild.com](https://www.buddybuild.com/) à l’aide du service qui héberge votre code (GitHub, Bitbucket, etc).
4. Ajoutez votre application à votre compte buddybuild (« Add a New App »).
5. Une fois la première intégration terminée, allez dans les réglages de l’app (« App Settings »). Dans « Test settings », activez les tests (« Run Tests », « Only run Tests »).
6. Enfin, cliquez sur « Configure » en face de « Run Tests » pour sélectionner les appareils et les versions d’iOS à tester. Sélectionnez au moins un appareil pour chaque version majeure d’iOS supportée par votre application.

![Test settings, buddybuild](/blog/img/2017/tester-ios-buddybuild/buddybuild-configuration-1.png)

![Device selection, buddybuild](/blog/img/2017/tester-ios-buddybuild/buddybuild-configuration-2.png)

Je sais, je sais. Dis comme ça, ça paraît assez compliqué. Mais cette configuration est en fait plutôt rapide, et surtout, devrait vous faire gagner beaucoup de temps à l’avenir. À chaque fois que vous pousserez un nouveau commit, buddybuild se chargera d’exécuter votre test sur toutes les configurations sélectionnées. En cas d’échec, vous recevrez un mail. Le reste du temps, vous pourrez continuer à travailler sans trop vous soucier des anciennes versions d’iOS.

Un test aussi basique ne permettra évidemment pas d’éviter toutes les régressions possibles. Mais il s’agit d’un premier pas important, et qui facilitera la mise en place de tests plus spécifiques par la suite.
