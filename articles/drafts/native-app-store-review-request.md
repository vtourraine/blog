# Demande d’App Store review, nouvelle génération

L’importance des notations sur l’App Store a généralisé le concept de demande de review (« App Store review request »), ces alertes qui encouragent, de façon plus ou moins insistante, l’utilisateur à laisser une review sur l’App Store. Tout ça pour obtenir le plus de ★★★★★. À tel point qu’Apple fournit depuis iOS 10.3 une API pour endiguer le phénomène, en posant des contraintes d’utilisation strictes.

Je suis ravi de cette nouvelle approche, à la fois comme utilisateur et comme développeur, mais le fonctionnement très particulier de cette API m’a laissé perplexe.

La méthode principale est une sorte de trou noir. En demandant l’affichage d’une requête, impossible d’en connaître le résultat. L’OS décidera s’il présente effectivement le dialogue à l’utilisateur, sur la base des réglages de l’appareil, et du nombre de fois que cette méthode a été invoquée précédemment.

Première conséquence de ce fonctionnement à l’aveugle : **il est impossible de l’utiliser pour un bouton dédié**. Un peu caché dans les réglages ou dans un écran d’information, ou trouve parfois un bouton pour proposer explicitement à l’utilisateur d’écrire une review. On ne peut pas sérieusement proposer un bouton dont l’action n’est pas garantie, sans pouvoir en connaître le résultat. La documentation évoque donc ce cas de figure, et conseille de rediriger alors l’utilisateur directement vers l’App Store par le biais d’une URL, en sortant complètement de l’app. Dommage de devoir se priver de l’API native.
