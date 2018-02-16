Title:     Synchroniser les numéros de version des Extensions  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      February 16, 2018  
Update:    
Keywords:  dev, Xcode  
Summary:   Les App Extensions gagnent chaque année en importance. Depuis leur introduction avec iOS 8, elles fonctionnent essentiellement comme des applications indépendantes, avec notamment leur propre numéro de version.  
Image:     
Language:  fr  


Les [App Extensions](https://developer.apple.com/app-extensions/) gagnent chaque année en importance. Depuis leur introduction avec iOS 8, elles fonctionnent essentiellement comme des applications indépendantes, avec notamment leur propre numéro de version.

La validation App Store impose aux Extensions d’avoir les mêmes numéros de version et de build (`CFBundleShortVersionString` et `CFBundleVersion`) que l’application principale. Une contrainte triviale, mais récurrente, puisqu’il s’agit de bien synchroniser ces valeurs, encore et encore, pour chaque nouvelle version.

En ajoutant un script au project Xcode, il devient possible d’automatiser cette tâche.

Les numéros de version sont stockés dans le fichier `Info.plist` de chaque target, donc dans un format XML. Pour y accéder plus facilement, on utilise généralement `PlistBuddy`, un utilitaire en ligne de commande inclus avec macOS. On prend les valeurs de référence dans l’application principale, puis on les applique à toutes les Extensions. Dans le script suivant, il suffit donc de configurer les chemins vers les différents fichiers `plist` :

<script src="https://gist.github.com/vtourraine/0f3ba2c1effeea238a7745758a4c147d.js"></script>

Pour ajouter ce script à votre projet Xcode, allez dans les « Build Phases » de votre target principale, cliquez sur le « + », puis sur « New Run Script Phase ». Il ne reste plus qu’à y copier-coller le script, bien configuré.

Le script sera donc exécuté à chaque fois que vous construisez l’application. En revanche, il me semble que le script n’est pas  systématiquement exécuté pour l’archivage de l’application. C’est un peu surprenant, puisque le « Build » fait techniquement partie du « Archive », mais il s’agit peut-être d’un mécanisme de mise en cache ou d’optimisation qui by-passe parfois cette étape. Si vous savez pourquoi cela se produit, et comment corriger ce problème, votre solution m’intéresse. En attendant, j’ai pris l’habitude de lancer un `⌘B` avant chaque archivage.

Et vraiment, la solution serait qu’Apple mette à jour Xcode pour automatiser complètement ce problème. Pour Xcode 10, peut-être ?
