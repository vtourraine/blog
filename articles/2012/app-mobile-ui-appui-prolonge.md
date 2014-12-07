Title:    Le mystère de l’appui prolongé  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     February 25, 2012  
Update:   
Keywords: mobile, UI, UX, making-of  
Summary:  Je sais, ça paraît ridicule, et pourtant en termes d’interface utilisateur mobile, l’appui prolongé est un vaste sujet à lui seul. Avec une multiplicité déroutante de cas d’utilisation, c’est un peu le grand incompris du multi-touch. En voilà un sujet intéressant.  
Image:    http://www.vtourraine.net/blog/img/app-mobile-ui-appui-prolonge/touch-hold.png  
Language: fr  
Project:  Contacts  

Je sais, ça paraît ridicule, et pourtant en termes d’interface utilisateur mobile, l’appui prolongé est un vaste sujet à lui seul. Avec une multiplicité déroutante de cas d’utilisation, c’est un peu le grand incompris du multi-touch. En voilà un sujet intéressant.

![Touch gesture][Touch gesture]


## Exemples (confus) avec iOS

Pour iOS, ce geste est assez rarement utilisé, et aucune signification particulière n'est établie. L'emploi le plus courant concerne la saisie de textes ([UITextField][]), pour permettre de déplacer le curseur d'édition, et faire apparaître le popover d'options contextuelles (copier, coller, etc). Moins remarquable, dans les listes de l'application "Music", il s'agit de faire apparaître un popover pour afficher les titres parfois trop longs. On note au passage que ces deux popovers sont gérés très différemment, ce qui tranche avec l'habituelle constance d'Apple en la matière. Mais ce n'est pas tout. Sur une carte, l'appui prolongé permet de déposer un nouveau repère ("pin"). Plus inattendu, l'application Mail [propose][Mail drafts] un raccourci pour ouvrir le dernier brouillon avec un appui prolongé sur le bouton de rédaction.

![Popover Notes][Popover Notes]

![Popover Music][Popover Music]

Difficile de voir clair là-dedans, donc, et aucune recommandation n'est émise à ce sujet dans les documents de référence ([iOS Human Interface Guidelines][Mobile HIG]).

Ceci dit, les *Gesture Recognizers* introduits avec le SDK 3.2 permettent de faciliter considérablement la détection des appuis prolongés. On a même droit à une sous-classe dédiée : [UILongPressGestureRecognizer][]. Si vous souhaitez utiliser ce type d'interactions dans votre appli, ne cherchez pas plus loin.


## Approches variées

Dans le cas d'Android, l'appui prolongé possède une signification bien plus établie : il s'agit de faire apparaître un menu contextuel, en rapport avec l'élément pointé. Il permet par exemple d'accéder à l'édition ou la suppression directe d'un élément de liste. Le principe fonctionne assez bien, et ne connaît pas d'équivalent direct sur iOS. Pour autant, ce geste pose certains problèmes.

Il est caché. Aucun élément visible ne vient vous rappeler cette possibilité. Lorsque les actions associées sont aussi communes, il s'agit d'un handicap réel, en particulier pour des utilisateurs novices.

Il donne une impression lenteur. Devoir attendre, même une demie seconde, pour un retour de l'interface est immanquablement perçu comme un manque de fluidité, et donc une perte d'efficacité. Comme l'expliquait [Matias Duarte][Duarte] (responsable de l'expérience utilisateur pour Android, dans une interview dont j'ai perdu le lien), c'est pourtant plutôt le contraire : ce geste est statistiquement plus rapide que le passage par un menu séparé avec sélection d'élément. Pas toujours facile de rationaliser le comportement d'un utilisateur.


## Ma contribution

J'ai déjà évoqué [ici][Blog guide utilisation] les problèmes rencontrés pour ma dernière application, [Contact[s]][], concernant l'absence volontaire de F.A.Q. et l'accompagnement de certains utilisateurs "désorientés". C'est à ce moment que l'appui prolongé m'est apparu comme une solution intéressante.

Plus précisément, il s'agit d'un simple bouton "+" permettant d'ajouter un contact. Je souhaitais proposer 2 choix, l'import depuis le carnet d'adresses ou bien la création à partir de zéro, mais sans complexifier l'interface. Présenter systématiquement une [Action Sheet][UIActionSheet] pour laisser le choix à l'utilisateur ? Trop envahissant. Ma solution consiste donc à utiliser un appui prolongé sur le bouton "+" pour présenter explicitement le choix en question, et à passer par le comportement le plus probable pour un appui normal.

En cas d'hésitation, un utilisateur a naturellement tendance à garder son doigt appuyé sur un bouton. C'est précisément le genre de situation où l'accompagnement est important, voire nécessaire. L'utilisateur hésite à finir son geste par manque d'assurance ? J'en profite pour lui proposer un choix plus détaillé, plus didactique.

![Contact[s] action sheet, Studio AMANgA][Contact[s] action sheet]

Il s'agit donc d'une approche permettant de dissimuler la complexité d'une application, tout en apportant *intelligemment* un renseignement ou un choix à l'utilisateur lorsqu'il en aura *a priori* besoin. 

Un peu d'assistance, pour ce grand incompris du multi-touch.


### Sources

- Icônes gestes multi-touch : [Gesturecons](http://gesturecons.com/)


[Touch gesture]: http://www.vtourraine.net/blog/img/app-mobile-ui-appui-prolonge/touch-hold.png
[Popover Notes]: http://www.vtourraine.net/blog/img/app-mobile-ui-appui-prolonge/notes-popover.jpg
[Popover Music]: http://www.vtourraine.net/blog/img/app-mobile-ui-appui-prolonge/music-popover.jpg
[Contact[s] action sheet]: http://www.vtourraine.net/blog/img/app-mobile-ui-appui-prolonge/contacts-action-sheet.png

[UITextField]: 									https://developer.apple.com/library/ios/documentation/uikit/reference/UITextField_Class/
[Mail drafts]: 									http://gizmodo.com/5887459/how-to-quickly-open-saved-email-drafts-in-ios
[Mobile HIG]: 									https://developer.apple.com/library/ios/#documentation/UserExperience/Conceptual/MobileHIG/Introduction/Introduction.html
[UILongPressGestureRecognizer]: https://developer.apple.com/library/ios/#DOCUMENTATION/UIKit/Reference/UILongPressGestureRecognizer_Class/Reference/Reference.html
[Duarte]: 										  https://plus.google.com/114892667463719782631
[Blog guide utilisation]: 			http://www.vtourraine.net/blog/app-mobile-guide-utilisation
[Contact[s]]: 									http://www.studioamanga.com/contacts/
[UIActionSheet]: 								https://developer.apple.com/library/ios/documentation/uikit/reference/UIActionSheet_Class/
