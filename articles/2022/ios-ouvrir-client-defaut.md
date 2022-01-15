Title:    Ouvrir le client mail choisi par l’utilisateur  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     January 15, 2022  
Update:   
Keywords: dev, iOS  
Summary:  Une application iOS peut facilement invoquer Apple Mail. Pour les autres clients mail (Gmail, Outlook, etc), j’ai créé ThirdPartyMailer. Cette bibliothèque utilise les *custom URL schemes* pour invoquer des applications spécifiques, avec certaines options : destinataire du mail, sujet, contenu, CC/BCC. Pratique, mais le développeur doit choisir le client à utiliser, ou offrir ce choix à l’utilisateur dans l’application.  
Image:    
Language: fr  


Une application iOS peut facilement invoquer Apple Mail avec `MFMailComposeViewController`. Pour les autres clients mail (Gmail, Outlook, etc), j’ai créé [ThirdPartyMailer](https://github.com/vtourraine/ThirdPartyMailer). Cette bibliothèque utilise les *custom URL schemes* pour invoquer des applications spécifiques, avec certaines options : destinataire du mail, sujet, contenu, CC/BCC. Pratique, mais le développeur doit choisir le client à utiliser, ou offrir ce choix à l’utilisateur dans l’application.

Or, depuis iOS 14, [un utilisateur peut définir un client mail par défaut](https://support.apple.com/en-us/HT211336) autre qu’Apple Mail. J’ai récemment découvert, grâce à [cet article](https://chris-mash.medium.com/goodbye-mfmailcomposeviewcontroller-4d9778e8d862) de Chris Mash, que `MFMailComposeViewController` ne respecte pas ce choix. Les URLs  `mailto`, en revanche, redirigent correctement. Cela m’est apparu être une opportunité pour ThirdPartyMailer.

Je préparais justement une version 2.0. Il m’a suffit de définir un nouveau client, `systemDefault`, avec le scheme `mailto`. Mieux, je l’ai assigné comme valeur par défaut du paramètre correspondant. Concrètement, ThirdPartyMailer peut maintenant très facilement ouvrir le client choisi par l’utilisateur :

```swift
// Ouverture simple
ThirdPartyMailer.openCompose()

// Ouverture avec paramètres
ThirdPartyMailer.openCompose(recipient: "friend@mail.com", subject: "Hello", body: "Good morning…", cc: "cc@mail.com", bcc: "bcc@mail.com")
```

Ça paraît tellement évident qu’on dirait une fonctionnalité native du SDK.

Si votre application invoque `MFMailComposeViewController`, je vous invite à utiliser [ThirdPartyMailer](https://github.com/vtourraine/ThirdPartyMailer) à la place. Vos utilisateurs vous en seront reconnaissants.
