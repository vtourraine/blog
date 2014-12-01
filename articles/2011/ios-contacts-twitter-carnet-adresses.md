Title:    iOS : Extraire un compte Twitter du carnet d’adresses
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     October 18, 2011  
Update:   
Keywords: iOS, iOS 5, Contacts, Twitter
Summary:  Avec iOS 5, le carnet d’adresses bénéficie de nouveaux champs de saisie pour les réseaux sociaux. Voyons comment récupérer ces informations.
Image:    http://www.vtourraine.net/blog/img/ios-contacts-twitter-carnet-adresses/contact.jpg
Language: fr

<p>Avec iOS 5, le carnet d’adresses bénéficie de nouveaux champs de saisie pour les réseaux sociaux. Voyons comment récupérer ces informations.</p>

<p>
	Le framework <em>AddressBook</em> est une mine d'informations depuis la première version du SDK, et iOS 5 continue d'apporter quelques renseignements intéressants. Soit dit en passant, je suis toujours étonné qu'aucune protection n'existe pour avertir l'utilisateur qu'une application parcourt son carnet d'adresses, comme c'est le cas pour la géolocalisation par exemple, mais ceci est un autre débat.
</p>
<div class="slideshow">
	<img src="img/ios-contacts-twitter-carnet-adresses/contact.jpg" alt="Contact" />
</div>
<p>
	Avec iOS 5, l'utilisateur peut donc renseigner les coordonnées d'une personne pour les principaux réseaux sociaux. Pour autant, l'extraction des données en question n'est ni très simple, ni abondamment documentée.
</p>
<p>
	Le plus intéressant concerne Twitter, grâce à son niveau d'intégration, mais la méthode qui va suivre s'applique également à tous les autres réseaux reconnus : Facebook, Flickr, LinkedIn et MySpace (sic). 
</p>
<h2>Rappels</h2>
<p>
	Le point de départ, c'est un <em>ABRecordRef</em>, qui permet d'identifier une fiche dans le carnet d'adresses. Vous pouvez récupérer cette valeur directement par itération, par recherche, ou bien avec le composant graphique standard <em>ABPeoplePickerNavigationController</em>.
</p>
<p>
	Vous pouvez alors accéder à certaines informations très facilement :
</p>
<code>
		ABRecordRef record = ...;<br/>
    <br/>
    NSString * prenom	= (NSString*)ABRecordCopyValue(record, kABPersonFirstNameProperty);<br/>
    [prenom release];
</code>
<p>
	D'autres un peu moins facilement (notamment lorsque plusieurs valeurs sont possibles) :
</p>
<code>
		ABMutableMultiValueRef telephones = ABRecordCopyValue(record, kABPersonPhoneProperty);<br/>
		CFIndex nbTelephones = ABMultiValueGetCount(telephones);<br/>
		for ( int k=0 ; k&lt;nbTelephones ; k++ ) {<br/>
		&nbsp;&nbsp;NSString * telephone = (NSString*) ABMultiValueCopyValueAtIndex(telephones, k);<br/>
		&nbsp;&nbsp;[telephone release];<br/>
		}<br/>
		CFRelease(telephones);
</code>
<h2>Twitter</h2>
<p>
	Pour les réseaux sociaux, associés à la propriété <em>kABPersonSocialProfileProperty</em>, c'est encore un peu plus compliqué, car chaque entrée correspond à un dictionnaire, avec les informations suivantes :
</p>
<ul>
	<li>
		<em>kABPersonSocialProfileServiceKey</em> : le réseau social concerné
	</li>
	<li>
		<em>kABPersonSocialProfileUsernameKey</em> : le nom d'utilisateur
	</li>
	<li>
		<em>kABPersonSocialProfileUserIdentifierKey</em> : l'identifiant de l'utilisateur (utile pour retrouver avec certitude un compte Facebook, par exemple)
	</li>
	<li>
		<em>kABPersonSocialProfileURLKey</em> : l'URL du profil en question (pour Twitter, il s'agit donc de 'http://www.twitter.com/xxx')
	</li>
</ul>
<p>
	Avec ces constantes, libre à vous de parcourir les données à votre disposition selon ce que vous souhaitez en faire. Voici par exemple une fonction qui retourne le nom du compte Twitter pour la personne passée en paramètre :
</p>
<code>
	- (NSString*)getTwitterUsernameFromRecord:(ABRecordRef)record {<br/>
	&nbsp;&nbsp;NSString * twitterUsername = nil;<br/>
	&nbsp;&nbsp;<br/>
	&nbsp;&nbsp;ABMutableMultiValueRef socials = ABRecordCopyValue(record, kABPersonSocialProfileProperty);<br/>
	&nbsp;&nbsp;CFIndex socialsCount = ABMultiValueGetCount(socials);<br/>
	<br/>
	&nbsp;&nbsp;for (int k=0 ; k&lt;socialsCount ; k++) {<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;CFDictionaryRef socialValue = ABMultiValueCopyValueAtIndex(socials, k);<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;if(CFStringCompare( CFDictionaryGetValue(socialValue, kABPersonSocialProfileServiceKey), kABPersonSocialProfileServiceTwitter, 0)==kCFCompareEqualTo) {<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;twitterUsername = (NSString*) CFDictionaryGetValue(socialValue, kABPersonSocialProfileUsernameKey);<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;}<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;CFRelease(socialValue);<br/>
	        <br/>
	&nbsp;&nbsp;&nbsp;&nbsp;if(twitterUsername)<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br/>
	&nbsp;&nbsp;}<br/>
	&nbsp;&nbsp;CFRelease(socials);<br/>
	    <br/>
	&nbsp;&nbsp;return twitterUsername;<br/>
	}
</code>
<h2>Références</h2>
<ul>
	<li>
		<a href="http://developer.apple.com/library/ios/#documentation/ContactData/Conceptual/AddressBookProgrammingGuideforiPhone/Introduction.html">Address Book Programming Guide for iOS</a>
	<li>
		<a href="http://developer.apple.com/library/ios/#documentation/AddressBook/Reference/ABPersonRef_iPhoneOS/Reference/reference.html">ABPerson Reference</a>
	</li>
</ul>