Title:     SF Symbols  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      October 14, 2021  
Update:    
Keywords:  iOS, dev  
Summary:   Les dernières versions d’iOS ont apporté beaucoup de nouveautés pour les développeurs. Si je devais n’en retenir qu’une, ce serait SF Symbols. Plus qu’une API, c’est une partie intégrante de l’OS, ouverte aux applications tierces.  
Image:     
Language:  fr  


Les dernières versions d’iOS ont apporté beaucoup de nouveautés pour les développeurs. Si je devais n’en retenir qu’une, ce serait [SF Symbols](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/). Plus qu’une API, c’est une partie intégrante de l’OS, ouverte aux applications tierces.

Avant SF Symbols, iOS ne proposait qu’une poignée d’images standardisées. La flèche qui sort d’un carré pour le partage, la loupe pour la recherche, et quelques autres. Des graphistes proposaient donc des packs d’icônes, plus ou moins proches des standards graphiques d’Apple. J’ai surtout utilisé [Glyphish](https://www.glyphish.com), parfois en modifiant les icônes proposées pour obtenir un résultat particulier. Mais tout ça, c’est fini.

Et à en juger par la centaine de nouveaux symboles ajoutés chaque année, je ne suis pas le seul à les apprécier. De nouvelles images, donc, mais aussi de nouvelles API pour davantage de flexibilité : taille, épaisseur, couleur, orientation, etc.

Tout n’est pas parfait. Bien sûr, il manque des icônes. La création de symboles personnalisés est possible, mais laborieuse. L’API est flexible, mais bizarrement inélégante. Par exemple, pour choisir une taille et un rendu des couleurs, il faut créer deux instances de `UIImage.SymbolConfiguration`, les combiner avec `applying(_)`, puis associer cette configuration à l’image concernée. Les noms des symboles ne sont pas définis dans le SDK, il faut donc déclarer avec des `String` dans le code. C’est d’autant plus regrettable que le compilateur ne peut pas tester la disponibilité du symbole selon la version d’iOS (pas de `if #available(iOS 15, *) {}`). De nombreuses améliorations sont possibles, mais rien qui empêche d’en profiter aujourd'hui.

Dès son introduction avec iOS 13, SF Symbols est devenu à mes yeux un élément incontournable du développement d’applications. Certains attendent les nouvelles versions d’iOS pour ses nouveaux emojis. Moi, ce serait plutôt pour ses nouveaux SF Symbols (et l’API qui vient avec).
