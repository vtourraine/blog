Title:    iOS : Extraire un compte Twitter du carnet d’adresses
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     October 18, 2011  
Update:   
Keywords: iOS, iOS 5, Contacts, Twitter
Summary:  Avec iOS 5, le carnet d’adresses bénéficie de nouveaux champs de saisie pour les réseaux sociaux. Voyons comment récupérer ces informations.
Image:    http://www.vtourraine.net/blog/img/ios-contacts-twitter-carnet-adresses/contact.jpg
Language: fr

Avec iOS 5, le carnet d’adresses bénéficie de nouveaux champs de saisie pour les réseaux sociaux. Voyons comment récupérer ces informations.

Le framework `AddressBook` est une mine d'informations depuis la première version du SDK, et iOS 5 continue d'apporter quelques renseignements intéressants. Soit dit en passant, je suis toujours étonné qu'aucune protection n'existe pour avertir l'utilisateur qu'une application parcourt son carnet d'adresses, comme c'est le cas pour la géolocalisation par exemple, mais ceci est un autre débat.

<div class="slideshow">
	<img src="http://www.vtourraine.net/blog/img/ios-contacts-twitter-carnet-adresses/contact.jpg" alt="Contact" />
</div>

Avec iOS 5, l'utilisateur peut donc renseigner les coordonnées d'une personne pour les principaux réseaux sociaux. Pour autant, l'extraction des données en question n'est ni très simple, ni abondamment documentée.

Le plus intéressant concerne Twitter, grâce à son niveau d'intégration, mais la méthode qui va suivre s'applique également à tous les autres réseaux reconnus : Facebook, Flickr, LinkedIn et MySpace (sic). 


## Rappels

Le point de départ, c'est un `ABRecordRef`, qui permet d'identifier une fiche dans le carnet d'adresses. Vous pouvez récupérer cette valeur directement par itération, par recherche, ou bien avec le composant graphique standard `ABPeoplePickerNavigationController`.

Vous pouvez alors accéder à certaines informations très facilement :

``` objc
ABRecordRef record = ...;

NSString *prenom	= (NSString*)ABRecordCopyValue(record, kABPersonFirstNameProperty);
[prenom release];
```

D'autres un peu moins facilement (notamment lorsque plusieurs valeurs sont possibles) :

``` objc
ABMutableMultiValueRef telephones = ABRecordCopyValue(record, kABPersonPhoneProperty);
CFIndex nbTelephones = ABMultiValueGetCount(telephones);
for ( int k=0 ; k<nbTelephones ; k++ ) {
  NSString *telephone = (NSString *) ABMultiValueCopyValueAtIndex(telephones, k);
  [telephone release];
}
CFRelease(telephones);
```

## Twitter

Pour les réseaux sociaux, associés à la propriété `kABPersonSocialProfileProperty`, c'est encore un peu plus compliqué, car chaque entrée correspond à un dictionnaire, avec les informations suivantes :

- `kABPersonSocialProfileServiceKey` : le réseau social concerné
- `kABPersonSocialProfileUsernameKey` : le nom d'utilisateur
- `kABPersonSocialProfileUserIdentifierKey` : l'identifiant de l'utilisateur (utile pour retrouver avec certitude un compte Facebook, par exemple)
- `kABPersonSocialProfileURLKey` : l'URL du profil en question (pour Twitter, il s'agit donc de 'http://www.twitter.com/xxx')

Avec ces constantes, libre à vous de parcourir les données à votre disposition selon ce que vous souhaitez en faire. Voici par exemple une fonction qui retourne le nom du compte Twitter pour la personne passée en paramètre :

``` objc
- (NSString *)getTwitterUsernameFromRecord:(ABRecordRef)record {
  NSString *twitterUsername = nil;

  ABMutableMultiValueRef socials = ABRecordCopyValue(record, kABPersonSocialProfileProperty);
  CFIndex socialsCount = ABMultiValueGetCount(socials);

  for (int k=0 ; k<socialsCount ; k++) {
    CFDictionaryRef socialValue = ABMultiValueCopyValueAtIndex(socials, k);
    if(CFStringCompare( CFDictionaryGetValue(socialValue, kABPersonSocialProfileServiceKey), kABPersonSocialProfileServiceTwitter, 0)==kCFCompareEqualTo) {
      twitterUsername = (NSString*) CFDictionaryGetValue(socialValue, kABPersonSocialProfileUsernameKey);
    }
    CFRelease(socialValue);
	        
    if(twitterUsername)
      break;
  }
  CFRelease(socials);
	    
  return twitterUsername;
}
```

### Références

- [Address Book Programming Guide for iOS](http://developer.apple.com/library/ios/#documentation/ContactData/Conceptual/AddressBookProgrammingGuideforiPhone/Introduction.html)
- [ABPerson Reference](http://developer.apple.com/library/ios/#documentation/AddressBook/Reference/ABPersonRef_iPhoneOS/Reference/reference.html)
