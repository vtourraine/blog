Title:     IFTTT, connecter les API entre elles  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      March 23, 2018  
Update:    
Keywords:  api  
Summary:   Les API sont d’abord utilisées pour mettre en relation deux applications, par exemple un serveur web et un client mobile. On parle aussi de l’importance des API pour « ouvrir » une base de données, et ainsi permettre des utilisations inédites. Tout ceci est formidable, mais je pense que le pouvoir ultime d’une API est finalement de permettre de se connecter à une autre API.  
Image:     
Language:  fr  


Les API sont d’abord utilisées pour mettre en relation deux applications, par exemple un serveur web et un client mobile. On parle aussi de l’importance des API pour « ouvrir » une base de données, et ainsi permettre des utilisations inédites. Tout ceci est formidable, mais je pense que le pouvoir ultime d’une API est finalement de permettre de se connecter à une autre API.

Cette mise en relation est souvent compliquée, car la plupart des API sont conçues comme indépendantes du reste. On partage bien des techniques (REST, OAuth, etc), mais concrètement, chaque API fonctionne différemment.

Voilà pourquoi un service comme [IFTTT](https://ifttt.com) est aussi utile. Il prend en charge les API les plus populaires (email, Twitter, Google Docs, et bien d’autres), et permet à l’utilisateur de configurer des interactions entre elles. IFTTT appelle ça des *recettes* (« recipes »). Mieux, la configuration est accessible à tous, avec une interface facile d’utilisation qui ne nécessite aucune connaissance en programmation informatique. C’est extrêmement basique, mais aussi étonnamment puissant.

Le service est entièrement gratuit. Sans doute un mauvais signe pour sa pérennité, et il convient de rester vigilant avant de lui donner des clés d’accès pour tous ses services web (si la plateforme est compromise, tous les services connectés sont évidemment concernés). Mais au delà d’IFTTT, l’idée d’un outil qui met en relation des API est très importante.

Je vais donner un exemple (trivial) avec la dernière *recette* que j’ai configuré sur mon compte. J’ai trouvé un blog avec une section qui publie rarement, mais qui m’intéresse beaucoup. Je ne vais pas suivre le blog dans son ensemble, le reste ne me concerne pas. Bonne nouvelle : le blog génère un flux RSS pour chaque section. Je prends donc l’adresse du flux qui m’intéresse, je la donne à IFTTT et lui demande d’envoyer tous les nouveaux articles sur mon compte Pocket pour pouvoir le lire plus tard.

Voilà comment deux services qui n’ont aucun lien, un CMS de blog d’un côté, et un service de lecture différée de l’autre, peuvent fonctionner ensemble. Merci les API.
