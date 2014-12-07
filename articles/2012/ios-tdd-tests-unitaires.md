Title:    Tests unitaires pour iOS  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     April 18, 2012  
Update:   
Keywords: iOS, Xcode, Objective-C, TDD, OCUnit  
Summary:  Le développement iOS bénéficie d’un langage solide (Objective-C) et d’un SDK moderne (Cocoa Touch). Il existe pourtant un aspect technique, généralement considéré comme essentiel, sur lequel la plateforme est en retard flagrant : les tests unitaires, et le “Test-Driven Development” (TDD) en particulier. C’est le moment de s’y mettre.  
Image:    http://www.vtourraine.net/blog/img/ios-tdd-tests-unitaires/xcode-ocunit.png  
Language: fr  
Project:  

Le développement iOS bénéficie d’un langage solide (Objective-C) et d’un SDK moderne (Cocoa Touch). Il existe pourtant un aspect technique, généralement considéré comme essentiel, sur lequel la plateforme est en retard flagrant : les tests unitaires, et le “Test-Driven Development” (TDD) en particulier. C’est le moment de s’y mettre.


## Pas assez « amazing » ?

Le problème, c'est peut-être qu'Apple ne fait pas beaucoup d'efforts. La [documentation][Doc Unit Testing] est modeste, le sujet n'est pas évoqué lors des [WWDC][] et les [codes d'exemples][Sample Codes] n'en contiennent jamais. À croire que les tests unitaires n'existent pas à Cupertino.

Le seul progrès récent dans ce domaine concerne l'intégration relativement poussée d'[OCUnit][] (SenTest, le framework ‘officiel’ pour les tests Objective-C) à Xcode 4. Lors de la création d'un nouveau projet, l'option “inclure tests unitaires” permet la configuration automatique du projet, avec « target » dédiée. Bien. Et le raccourci `‘Cmd’ + ‘U’` permet effectivement de lancer facilement l'exécution des tests, sur un appareil ou avec le simulateur. 

![OCUnit avec Xcode][Xcode OCUnit]

Pourtant, même si on ne dispose pas vraiment de statistiques sur le sujet, le constat est facile à établir : la très grande majorité des développeurs iOS (Mac ?) codent sans tests.


## Se mettre aux tests

Je vais prendre un exemple que je maîtrise plutôt bien : moi. J'ai passé 3 ans à développer des applications iOS sans écrire le moindre test. J'avais sans doute passé plus de temps avec JUnit qu'avec OCUnit, chose assez incroyable. 

Mais depuis quelques mois, je me soigne. Le TDD est mon ami, et comme avec tous les amis il faut lui consacrer beaucoup de temps, mais il le rend bien. Et on rigole souvent à la fin de la journée de toutes ces galères communes.

Les ressources pour se former à la pratique des tests unitaires sur iOS sont rares, on peut donc facilement en faire le tour. À ma connaissance, c'est Graham Lee ([@secboffin][Twitter Lee], a.k.a. « Rouflaquette ») qui remporte le titre de référence en la matière. Vous pouvez le retrouver dans une Master class sur le site [iDeveloper TV](http://ideveloper.tv/video/unittestingcourse.html), avec des présentations vidéos très instructives. N'hésitez pas à vous les procurer. Il vient également tout juste de publier le premier livre consacré à ce sujet, « [Test-Driven iOS Development](http://www.amazon.com/Test-Driven-iOS-Development-Developers-Library/dp/0321774183/ref=sr_1_2) ». Le contenu reprend largement celui des vidéos, mais s'attarde particulièrement sur les grands principes du TDD avec des exemples très détaillés, sans pour autant entrer davantage dans les détails techniques particuliers à iOS. Comme expliqué en haut de ce billet, cette pédagogie est sans doute nécessaire pour la plupart des développeurs concernés.

![Test-Driven iOS Development][TDD iOS dev]

Une fois les bases assimilées, il ne reste plus qu'à plonger dans [OCMock](http://ocmock.org/), [OCHamcrest](http://jonreid.github.com/OCHamcrest/) et autres [Cedar](https://github.com/pivotal/cedar). Autant de sujets qui méritent des billets dédiés, peut-être pour plus tard. Ça vous laisse le temps pour vous familiariser avec OCUnit. `‘Cmd’+‘U’`.


[Xcode OCUnit]: http://www.vtourraine.net/blog/img/ios-tdd-tests-unitaires/xcode-ocunit.png
[TDD iOS dev]:  http://www.vtourraine.net/blog/img/ios-tdd-tests-unitaires/graham-lee-tdd-ios.png

[Doc Unit Testing]: http://developer.apple.com/library/ios/#documentation/DeveloperTools/Conceptual/UnitTesting/00-About_Unit_Testing/about.html
[WWDC]:             https://developer.apple.com/wwdc/
[Sample Codes]:     https://developer.apple.com/library/ios/navigation/index.html?section=Resource+Types&topic=Sample+Code
[OCUnit]:           http://www.sente.ch/software/ocunit/
[Twitter Lee]:      http://twitter.com/secboffin
