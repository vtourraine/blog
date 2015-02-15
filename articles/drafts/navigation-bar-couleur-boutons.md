# Tient bon la barre (de navigation)

Je ne me lasse pas d’évoquer sur ce blog les quelques points qui définissent fondamentalement l’interface des applications iPhone (donc UIKit), aujourd’hui il sera donc question de la barre de navigation. 

Cet élément d'interface est un véritable coup de génie, qui arrive à adresser les 3 grandes questions : qui suis-je, d'où viens-je et où vais-je :

- Au centre, le titre de l'écran en cours. Il prend par défaut la valeur du `title` du view controller au premier plan, ou peut être customisé par une instance de `UIView`, aussi simple ou complexe soit-elle. Comme indiqué dans les HIG, on rappellera au passage qu'il convient de ne pas y mettre le nom de l'application elle-même, comme beaucoup en sont tentés. 

- À gauche, le bouton de retour à l'écran précédent. En plus d'être en forme de flèche orientée vers la gauche, convention déjà bien établie par les navigateurs internet avec leur bouton « précédent », ce bouton contient précisément le titre de l'écran auquel il fait référence. Cette conception fait tout la différence avec par exemple le système Android, qui présente un bouton omniscient « retour » uniquement sous forme de flèche, qui ne permet donc pas de visualiser le point auquel il fait référence. Ce point de repère constant est fondamental pour accompagner l'utilisateur dans sa navigation. 

- À droite, même si c'est beaucoup plus variable, on trouve souvent un bouton d'action principale. Dans Notes, créer une nouvelle note. Dans le caledrier, éditer l'événement sélectionné. Ce `rightBarButtonItem` est une instance de `UIBarButtonItem`, présentant parfois une image, parfois un titre lorsqu'il n'existe pas d’iconographie correspondante évidente. 

Cette organisation n'est pas fixe, on peut donc customiser la barre de navigation selon les besoins de l'application ou de l'écran en cours. Il faut cependant une bonne raison pour s'écarter de cette convention, tant elle facilite la prise en main pour un nouvel utilisateur, tout en garantissant la bonne structure générale d'une application. 

Je veux aussi m'arrêter un instant sur ces quelques détails d'implémentation de la barre de navigation dans iOS, qui subliment les principes évoqués ci-dessus. On définit généralement cette barre avec quelques chaînes de caractères, et notamment les titres des view controllers présent et passé. Que se passe-t-il quand ces chaînes sont trop longues pour tenir sur les 320 points de largeur d'un écran d'iPhone ? Le système tronque simplement -et surtout automatiquement- les titres pour s'accommoder de la place disponible, et en donnant la priorité au titre central. Trop peu de place pour le titre de l'écran précédent ? iOS utilise alors « Back/Retour » comme valeur compacte alternative. Dans le cas le plus extrême, seule la flèche vers la gauche subsiste, comme minimum vital de navigation. 

// bouton bleu/gras pour la validation

Autre détail fantastique arrivé lui avec iOS 7, le push du navigation controller associé anime maintenant la transition du titre central actuel qui devient le bouton de retour à gauche, et inversement pour le pop. C'est un peu difficile à décrire comme ça, mais c'est magnifique à manipuler. Encore une fois, tout ça est géré automatiquement, sans la moindre ligne de code supplémentaire pour une application tierce. 

## iOS 7, et le problème de la couleur

Tout allait bien dans le meilleur des mondes, jusqu'à l'arrivée d'iOS 7. Le principe reste le même, mais un détail vient tout perturber : les boutons sans bord. La goutte d'eau qui a fait déborder le vase de l'obsession de Jony Ive à tout simplifier. 

Les trois principaux éléments de la barre de navigation étaient clairement délimités, avec le texte du titre au milieu, et les boutons bordés de chaque côté. Sans les bords, il ne reste que du texte, difficile à dissocier visuellement. À défaut, iOS incite alors à utiliser la couleur pour préserver un peu de structure. L'approche est relativement satisfaisante pour une barre de navigation blanche, comme dans la plupart des applications de base, avec un titre en noir (pas d'action) et des bar button items bleus (avec une action). 

Le problème, c'est que la majorité des applications tierces se démarquent justement en utilisant des barres de navigation colorées, laissant des titres et des boutons en texte... blancs. En termes de langage visuel et d'ergonomie, c'est une catastrophe. Difficile de trouver une seconde couleur pour les boutons actifs qui soit visuellement plaisante et suffisamment contrastée. On peut utiliser une légère teinte de gris, mais cette couleur est normalement associée à des boutons inactifs (aïe le contresens), et n'est pas naturelle pour un titre central non plus. 

À mon avis, il s'agit véritablement d'un point problématique avec iOS 7+, et je ne vois pas encore de solution claire émerger. Comme souvent, de nouvelles approches continueront d'émerger dans des applications tierces, les meilleures idees évoluant generalement en bonnes pratiques répandues au fil du temps, comme ce fut le cas pour le pull-to-refresh ou le swipe-left-to-pop. 

Tout ça ne doit pas nous empêcher de célébrer cette petite merveille d'interface utilisateur qui fait le bonheur des développeurs comme des utilisateurs, et qui donnent à iOS ce petit je ne sais quoi de perfection. 