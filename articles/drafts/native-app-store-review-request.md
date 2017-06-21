# Notations App Store, nouvelle génération

L’importance des notations sur l’App Store a généralisé le concept de « Please rate this app ». Ces alerts encouragent, de façon plus ou moins insistante, l’utilisateur à laisser un avis (« review » en VO) sur l’App Store. Tout ça pour obtenir le plus de ★★★★★. Voilà pourquoi Apple fournit depuis iOS 10.3 une API pour standardiser ce phénomène, et a très récemment modifié les règles de validation des apps pour interdire les alertes non-officielles.

Je suis ravi de cette nouvelle approche, à la fois comme utilisateur et comme développeur, mais le fonctionnement très particulier de cette API m’a laissé perplexe.

La méthode principale est une sorte de trou noir. En demandant l’affichage d’une requête, impossible d’en connaître le résultat. L’OS décidera s’il présente effectivement le dialogue à l’utilisateur, sur la base des réglages de l’appareil, et du nombre de fois que cette méthode a été invoquée précédemment.

Ce qui nous amène au problème central : **quel est le bon moment pour (essayer de) présenter la demande de notation ?**

## Demander au bon moment

La réponse dépend forcément du mode de fonctionnement de votre application. Globalement, il convient de ne pas demander trop tôt (pour ne pas embêter un utilisateur en phase de découverte), mais ne pas trop attendre non plus (pour espérer obtenir un nombre significatif d’évaluations). Cette estimation était déjà problématique initialement, mais cette nouvelle API accentue cette difficulté.

À mes yeux, la solution réside dans une bibliothèque comme [iRate](https://github.com/nicklockwood/iRate), qui devient quasiment indispensable pour cette tâche.

Il suffit d’intégrer la bibliothèque à votre projet (par exemple avec CocoaPods) pour en bénéficier. iRate enregistre le nombre de lancements de l’application et les changements de version, pour proposer la notation au moment qui semblera le plus opportun. Ces réglages peuvent être personnalisés, et il est également possible de désactiver l’affichage automatique, pour contrôler entièrement sa présentation. Surtout, la bibliothèque détecte si l’API native est disponible, et l’utilise le cas échéant.

Petit bémol, cette approche a tendance à produire des faux positifs. Parfois le système refusera de présenter la demande, ce qui conduira donc iRate à complètement ignorer cette version de l’application. Ça me paraît une limitation raisonnable, surtout si vous avez l’habitude de publier régulièrement des mises à jour.

## Demande explicite

Autre conséquence du fonctionnement « à l’aveugle » de cette nouvelle API : **il est impossible de l’utiliser avec un bouton dédié**. Un peu caché dans les réglages ou dans un écran d’information, ou trouve parfois un bouton pour proposer explicitement à l’utilisateur d’écrire un avis. On ne peut pas sérieusement proposer un bouton dont l’action n’est pas garantie, sans pouvoir en connaître le résultat. La documentation évoque donc ce cas de figure, et conseille de rediriger alors l’utilisateur directement vers l’App Store par le biais d’une URL, en sortant complètement de l’app. Dommage de devoir se priver de l’API native. Mais là aussi, iRate est très utile, puisqu’elle peut gérer cette navigation tout simplement, avec la méthode `openRatingsPageInAppStore`.

// Un peu sceptique sur l’interdiction des custom alerts