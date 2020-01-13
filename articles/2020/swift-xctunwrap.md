Title:     Tester et déballer un optionnel avec XCTUnwrap  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      January 13, 2020  
Update:    
Keywords:  dev, Swift  
Summary:   Xcode 11 facilite la manipulation des optionnels dans les tests unitaires en introduisant une nouvelle fonction : XCTUnwrap.  
Image:     
Language:  fr  


Xcode 11 facilite la manipulation des optionnels dans les tests unitaires en introduisant une nouvelle fonction : `XCTUnwrap`.

Elle permet de tester qu’une expression n’est pas `nil`, et la retourne déballée. En une seule ligne, on évite ainsi les assortiments de `if`‌, `XCTAssertNotNil` et autres `XCTFail`.

Lorsque l’expression est `nil`, `XCTUnwrap` produit une exception. Il ne faut donc pas oublier de déclarer la fonction de test comme faillible (avec le mot clé `throws`), et de préfixer le résultat de `XCTUnwrap` avec `try`.

Voici un exemple :

``` swift
func testExample() throws {
  let expression = try XCTUnwrap(Expression())
  XCTAssertEqual(expression.foo, 123)
}
```

Le test est plus concis, plus clair, et plus expressif. Ce serait dommage de s’en passer.

[Documentation](https://developer.apple.com/documentation/xctest/3380195-xctunwrap)
