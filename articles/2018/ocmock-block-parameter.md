Title:     Tester l’exécution d’un block en paramètre avec OCMock  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      March 8, 2018  
Update:    
Keywords:  dev, Objective-C, unit test  
Summary:   J’utilise OCMock pour écrire des tests unitaires avec Objective-C depuis plusieurs années, mais je viens tout de juste de découvrir un nouveau cas d’utilisation, pas vraiment évident, mais bien pratique. Il s’agit de configurer un mock pour invoquer un block passé en paramètre.  
Image:     
Language:  fr  


J’utilise [OCMock](http://ocmock.org) pour écrire des tests unitaires avec Objective-C depuis plusieurs années, mais je viens tout de juste de découvrir un nouveau cas d’utilisation, pas vraiment évident, mais bien pratique. Il s’agit de configurer un _mock_ pour invoquer un block passé en paramètre.

Pour donner un exemple concret, ça me permet de tester des méthodes qui interagissent avec une API. Je _stub_ la méthode censée lancer la requête, et j’y attache la réponse attendue en JSON. De cette manière, tout se passe localement, mais le code est testé de façon asynchrone, comme pour une utilisation normale. Il existe bien sûr plusieurs façons de tester cette situation, mais la technique évoquée ici a le mérite de la brièveté. Tout passe par la méthode `invokeBlockWithArgs:` de `OCMArg`.

Un extrait de code sera sans doute plus parlant. J’ai un objet `NetworkManager`, avec deux méthodes. Une méthode `GET:completion:` de bas niveau, comparable à ce qu’on trouve dans AFNetworking par exemple, qui envoie la requête sur le réseau. La deuxième méthode, `fetchDataCompletion:`, est celle qui nous intéresse. Elle appelle la première méthode, et traite son résultat avant de le retourner dans un block.

``` objc
@interface NetworkManager : NSObject

- (void)GET:(NSString *)path completion:(void(^)(NSData *))completion;
- (void)fetchDataCompletion:(void(^)(NSString *))completion;

@end
```

Pour tester cette méthode `fetchDataCompletion:`, je peux donc utiliser `OCMock`, avec un stub sur `GET:completion:`. Pour valider le résultat, j’utilise un `XCTestExpectation`.

``` objc
- (void)testExample {
  NetworkManager *manager = [[NetworkManager alloc] init];
  id mockManager = OCMPartialMock(manager);

  NSData *stubData = [@"success" dataUsingEncoding:NSUTF8StringEncoding];
  OCMStub([mockManager GET:@"/blabla" completion:([OCMArg invokeBlockWithArgs:stubData, nil])]);

  XCTestExpectation *expectation = [self expectationWithDescription:@"should be a success"];

  [mockManager fetchDataCompletion:^(NSString *response) {
    XCTAssertEqualObjects(response, @"success");
    [expectation fulfill];
  }];

  [self waitForExpectations:@[expectation] timeout:1];
}
```

Je m’assure ainsi que la méthode lance une requête avec les bons paramètres (ici, le chemin), et transforme correctement le résultat (ici, conversion de `NSData` à `NSString`).

Pour tester un code responsable d’interagir avec une API, de la formation des requêtes au parsing des réponses, je trouve cette solution très satisfaisante. Ce n’est pas le code le plus lisible de l’histoire de l’informatique, mais pour le problème posé, on s’en tire plutôt bien.

_Code source complet sur [Gist](https://gist.github.com/vtourraine/06b4f6e762e58b5ac941ca6cd19235e3)_
