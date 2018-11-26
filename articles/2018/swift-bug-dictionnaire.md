Title:     Bug d’itération de dictionnaire  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      November 26, 2018  
Update:    
Keywords:  dev, iOS, Swift  
Summary:   Je fais parfois des erreurs vraiment basiques. Par exemple, je viens de comprendre la cause d’un bug qui me contrariait depuis plusieurs semaines. Mon erreur : j’utilisais un dictionnaire à la place d’un tableau.  
Image:     
Language:  fr  


Je fais parfois des erreurs vraiment basiques. Par exemple, je viens de comprendre la cause d’un bug qui me contrariait depuis plusieurs semaines. Mon erreur : j’utilisais un dictionnaire à la place d’un tableau. 🙄

Le projet en question récupère des données d’une page HTML pour les afficher sous forme de texte simple. Il n’existe pas d’API classique, je dois donc extraire l’information qui m’intéresse des tags HTML concernés. Pour nettoyer le résultat, je remplace certaines chaînes de caractères, notamment pour transformer les `<br>` en `\n`, avant d’éliminer les tags restant à l’aide d’une regex. Ce n’est pas l’algorithme du siècle, mais c’est suffisant pour obtenir le résultat souhaité.

``` swift
var deHTMLedString = string

let replacements = ["<br>": "\n", "<br />": "\n", "\n\n": "\n", "<p>": "", "</p> <button class=\'close-comment\'>X</button>": "", "</p>": ""]

for (original, target) in replacements {
  deHTMLedString = deHTMLedString?.replacingOccurrences(of: original, with: target)
}

deHTMLedString = deHTMLedString?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
```

Ou plutôt, c’est suffisant pour obtenir le résultat souhaité... parfois. Je ne comprenais pas pourquoi, mais le résultat était parfois erroné, avec par exemple des retours à la ligne en double qui persistaient, et des « X » superflus qui traînaient de temps en temps.

Intuitivement, je me disais que l’erreur devait venir de la page web à la source de ces données. Un CMS instable, peut-être. Un problème avec une certaine version d’iOS. Ou alors un bug avec le compilateur Swift, sachant que je reste toujours plus à l’aise avec Objective-C. Dit autrement : mon code était valide, l’erreur devait forcément venir de quelqu’un d’autre.

En relisant mon code attentivement, j’ai fini par comprendre d’où venait le problème. L’itération sur un dictionnaire ne garantit pas d’ordre, et mon code produit un résultat différent selon l’ordre de ces remplacements.

C’est vexant, parce que je connais très bien cette règle. Je l’avais simplement ignorée au moment d’écrire le code, sans y repenser par la suite. 

Là où ça devient intéressant, c’est que l’ordre en question peut varier d’une exécution à l’autre, même si les paramètres en entrée sont strictement identiques. En conséquence, ce bug produit des résultats virtuellement aléatoires. J’avais bien des tests unitaires pour valider cette fonction, mais bien sûr leur exécution avait la même instabilité.

Pour corriger, donc, il suffit de transformer la déclaration de la constante `replacements` en tableau du tuples (très pratique avec Swift, pour Objective-C il faudrait un peu plus de gymnastique). Même pas besoin de toucher à la boucle `for`.

``` swift
let replacements = [("<br>", "\n"), ("<br />", "\n"), ("\n\n", "\n"), ("<p>", ""), ("</p> <button class=\'close-comment\'>X</button>", ""), ("</p>", "")]
```

Voilà, le tour est joué. Le code HTML est correctement formaté et le bug envolé.
