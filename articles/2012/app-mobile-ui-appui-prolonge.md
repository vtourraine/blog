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

<p>Je sais, ça paraît ridicule, et pourtant en termes d’interface utilisateur mobile, l’appui prolongé est un vaste sujet à lui seul. Avec une multiplicité déroutante de cas d’utilisation, c’est un peu le grand incompris du multi-touch. En voilà un sujet intéressant.</p>

<div class="slideshow">
	<img src="http://www.vtourraine.net/blog/img/app-mobile-ui-appui-prolonge/touch-hold.png" class="nostyle" alt="Touch gesture" />
</div>

<h2>Exemples (confus) avec iOS</h2>
<p>Pour iOS, ce geste est assez rarement utilisé, et aucune signification particulière n'est établie. L'emploi le plus courant concerne la saisie de textes (<a href="https://developer.apple.com/library/ios/documentation/uikit/reference/UITextField_Class/">UITextField</a>), pour permettre de déplacer le curseur d'édition, et faire apparaître le popover d'options contextuelles (copier, coller, etc). Moins remarquable, dans les listes de l'application "Music", il s'agit de faire apparaître un popover pour afficher les titres parfois trop longs. On note au passage que ces deux popovers sont gérés très différemment, ce qui tranche avec l'habituelle constance d'Apple en la matière. Mais ce n'est pas tout. Sur une carte, l'appui prolongé permet de déposer un nouveau repère ("pin"). Plus inattendu, l'application Mail <a href="http://gizmodo.com/5887459/how-to-quickly-open-saved-email-drafts-in-ios">propose</a> un raccourci pour ouvrir le dernier brouillon avec un appui prolongé sur le bouton de rédaction.
</p>

<div class="slideshow">
	<img src="http://www.vtourraine.net/blog/img/app-mobile-ui-appui-prolonge/notes-popover.jpg" alt="Notes popover" />
	<img src="http://www.vtourraine.net/blog/img/app-mobile-ui-appui-prolonge/music-popover.jpg" alt="Music popover" />
</div>

<p>
	Difficile de voir clair là-dedans, donc, et aucune recommandation n'est émise à ce sujet dans les documents de référence (<a href="https://developer.apple.com/library/ios/#documentation/UserExperience/Conceptual/MobileHIG/Introduction/Introduction.html">iOS Human Interface Guidelines</a>).
</p>

<p>
	Ceci dit, les <em>Gesture Recognizers</em> introduits avec le SDK 3.2 permettent de faciliter considérablement la détection des appuis prolongés. On a même droit à une sous-classe dédiée : <a href="https://developer.apple.com/library/ios/#DOCUMENTATION/UIKit/Reference/UILongPressGestureRecognizer_Class/Reference/Reference.html">UILongPressGestureRecognizer</a>. Si vous souhaitez utiliser ce type d'interactions dans votre appli, ne cherchez pas plus loin.
</p>

<h2>Approches variées</h2>
<p>
	Dans le cas d'Android, l'appui prolongé possède une signification bien plus établie : il s'agit de faire apparaître un menu contextuel, en rapport avec l'élément pointé. Il permet par exemple d'accéder à l'édition ou la suppression directe d'un élément de liste. Le principe fonctionne assez bien, et ne connaît pas d'équivalent direct sur iOS. Pour autant, ce geste pose certains problèmes.
</p>
<p>
	Il est caché. Aucun élément visible ne vient vous rappeler cette possibilité. Lorsque les actions associées sont aussi communes, il s'agit d'un handicap réel, en particulier pour des utilisateurs novices.
</p>
<p>
	Il donne une impression lenteur. Devoir attendre, même une demie seconde, pour un retour de l'interface est immanquablement perçu comme un manque de fluidité, et donc une perte d'efficacité. Comme l'expliquait <a href="https://plus.google.com/114892667463719782631">Matias Duarte</a> (responsable de l'expérience utilisateur pour Android, dans une interview dont j'ai perdu le lien), c'est pourtant plutôt le contraire : ce geste est statistiquement plus rapide que le passage par un menu séparé avec sélection d'élément. Pas toujours facile de rationaliser le comportement d'un utilisateur.
</p>

<h2>Ma contribution</h2>
<p>
	J'ai déjà évoqué <a href="http://www.vtourraine.net/blog/app-mobile-guide-utilisation">ici</a> les problèmes rencontrés pour ma dernière application, <a href="http://www.studioamanga.com/contacts/">Contact[s]</a>, concernant l'absence volontaire de F.A.Q. et l'accompagnement de certains utilisateurs "désorientés". C'est à ce moment que l'appui prolongé m'est apparu comme une solution intéressante.
</p>
<p>
	Plus précisément, il s'agit d'un simple bouton "+" permettant d'ajouter un contact. Je souhaitais proposer 2 choix, l'import depuis le carnet d'adresses ou bien la création à partir de zéro, mais sans complexifier l'interface. Présenter systématiquement une <a href="https://developer.apple.com/library/ios/documentation/uikit/reference/UIActionSheet_Class/">Action Sheet</a> pour laisser le choix à l'utilisateur ? Trop envahissant. Ma solution consiste donc à utiliser un appui prolongé sur le bouton "+" pour présenter explicitement le choix en question, et à passer par le comportement le plus probable pour un appui normal.
</p>
<p>
	En cas d'hésitation, un utilisateur a naturellement tendance à garder son doigt appuyé sur un bouton. C'est précisément le genre de situation où l'accompagnement est important, voire nécessaire. L'utilisateur hésite à finir son geste par manque d'assurance ? J'en profite pour lui proposer un choix plus détaillé, plus didactique.
</p>

<div class="slideshow">
	<img src="http://www.vtourraine.net/blog/img/app-mobile-ui-appui-prolonge/contacts-action-sheet.png" class="nostyle" alt="Contacts action sheet" />
</div>

<p>
	Il s'agit donc d'une approche permettant de dissimuler la complexité d'une application, tout en apportant <em>intelligemment</em> un renseignement ou un choix à l'utilisateur lorsqu'il en aura <em>a priori</em> besoin. 
</p>
<p>
	Un peu d'assistance, pour ce grand incompris du multi-touch.
</p>

<h2>Sources</h2>
<p>
	Icônes gestes multi-touch : <a href="http://gesturecons.com/">Gesturecons</a>
</p>