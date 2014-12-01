Title:    Guides d’utilisation pour applications mobiles
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     February 05, 2012  
Update:   
Keywords: mobile, UI, UX, making-of  
Summary:  Les applications mobiles arrivent rarement avec un manuel d’utilisation, et personne ne s’en plaint. A priori, c’est donc une excellente nouvelle, mais ce n’est pas une raison pour ne pas guider ses utilisateurs, lorsque cela devient nécessaire. Étude de cas.  
Image:    http://www.vtourraine.net/blog/img/app-mobile-guide-utilisation/contacts-popover-front.png  
Language: fr  
Project:  Contacts  

<p>Les applications mobiles arrivent rarement avec un manuel d’utilisation, et personne ne s’en plaint. A priori, c’est donc une excellente nouvelle, mais ce n’est pas une raison pour ne pas guider ses utilisateurs, lorsque cela devient nécessaire. Étude de cas.</p>

<p>
	Pour concevoir "<a href="http://www.studioamanga.com/contacts/">Contact[s]</a>", j'ai décidé de reprendre l'interface de l'application Météo officielle, qui arrive préchargée sur tous les iPhones. Le principe est simple : on visualise sur la face avant, et on édite sur la face arrière. Ça me semble simple et familier, puisque présent depuis la première version d'iOS. 
</p>
<p>
	Seulement voilà, force est de constater que cette interface n'est pas limpide pour tout le monde. Depuis la sortie de "<a href="http://www.studioamanga.com/contacts/">Contact[s]</a>" il y a seulement quelques mois, j'ai déjà une dizaine d'emails (une majorité des retours) d'utilisateurs visiblement perdus, me demandant comment faire pour  éditer les informations à l'intérieur de l'application. C'est plutôt mauvais signe.
</p>
<p>
	Il s'agit pourtant d'un problème bien connu (mais souvent éludé) : l'application "vide". Comment faire pour que l'utilisateur ne se retrouve pas face à un écran blanc lors de la première utilisation. Je vous conseille de faire un tour sur l'excellent <a href="http://mobile-patterns.com/empty-data-sets">mobile-patterns.com</a> pour constater la multiplicité des solutions possibles.
</p>
<p>
	Dans mon cas, je me contentais d'un pop-up d'accueil au premier lancement, proposant de rediriger directement vers l'ajout d'un contact. Insuffisant, donc. Je me suis alors amusé à implémenter une version très simple de popover pour guider l'utilisateur lorsqu'aucune donnée n'est présente.
</p>
<div class="slideshow">
	<img src="img/app-mobile-guide-utilisation/contacts-popover-front.png" class="nostyle" alt="Contacts screenshot 1" />
	<img src="img/app-mobile-guide-utilisation/contacts-popover-back.png" class="nostyle" alt="Contacts screenshot 2" />
</div>
<p>
	Et ça marche : depuis cette mise à jour, plus aucun mail à ce sujet.
</p>
<p>
	<em>Mission accomplie</em>, ouf.
</p>