Title:    Nano Notes avec titres formattés  
Author:   Vincent Tourraine  
Email:    me@vtourraine.net  
Date:     May 16, 2023  
Update:   
Keywords: dev, iOS  
Summary:  Nano Notes est une application très simple. Un écran avec la liste des notes et un écran pour modifier une note. Côté code, ça donne une UITableView et une UITextView.  
Image:    https://www.vtourraine.net/blog/img/2023/nano-notes-titre/nano-notes-comp.jpg  
Language: fr  


[Nano Notes](https://www.studioamanga.com/nanonotes/) est une application très simple. Un écran avec la liste des notes et un écran pour modifier une note. Côté code, ça donne une `UITableView` et une `UITextView`.

Pour chaque note, la première ligne constitue son titre. Sur la liste des notes, ces titres sont affichés en gras. Pour l’écran d’édition, il serait donc logique d’afficher la première ligne en gras. Hélas, hélas, je n’ai jamais trouvé comment implémenter ça en gardant le texte modifiable. Je me doutais que la solution était du côté de Core Text, et demanderait un niveau de complexité bien trop élevé pour une application si modeste.

Et puis, un beau jour (le mois dernier), j’ai trouvé une solution !

L’astuce consiste à exploiter la propriété `attributedText` de `UITextView`. Plus précisément, avec `textStorage`, il est possible d’ajouter et de retirer des attributs sans affecter la saisie en cours. Voici donc le résultat :

![PlayGuide 1.2 sur iPhone](/blog/img/2023/nano-notes-titre/nano-notes-comp.jpg)

Vous ne pouvez pas savoir comme ce changement me fait plaisir. L’application a enfin l’interface qui convient !

Pour les plus curieux, voici le code en question. Ce n’est pas très élégant, mais ça fonctionne. Quand le texte change, il faut regarder si la première ligne se termine par un texte non-gras (on applique alors l’attribut), ou si la deuxième ligne commence par du gras (on retire alors l’attribut). Les va-et-vient entre `NSString`/`NSRange` et `String`/`Range` sont assez pénibles, mais difficiles à éviter pour la configuration actuelle du projet.

``` swift
func configureView() {
  // ...

  let attributedText = NSMutableAttributedString(string: text,   attributes: [.font: noteFont(), .foregroundColor: UIColor.label])
  let range = NSString(string: text).range(of:   text.firstLineAsTitle())
  if range.location != NSNotFound {
    attributedText.setAttributes([.font: titleFont(), .foregroundColor: UIColor.label], range: range)
  }
  textView?.attributedText = attributedText
  textView?.isEditable = true
}
  
// ...

func textViewDidChange(_ textView: UITextView) {
  let firstLineBreakRange = NSString(string: textView.text).range(of: "\n")
  guard firstLineBreakRange.location != NSNotFound else {
    // Always set first line as bold
    let range = NSRange(location: 0, length: textView.attributedText.length)
    textView.textStorage.removeAttribute(.font, range: range)
    textView.textStorage.addAttribute(.font, value: titleFont(), range: range)
    return
  }

  var effectiveRange = NSRange()

  let attributesAtFirstLineBreak = textView.attributedText.attributes(at: firstLineBreakRange.lowerBound, effectiveRange: &effectiveRange)
  if let fontAtFirstLineBreak = attributesAtFirstLineBreak[.font] as? UIFont, fontAtFirstLineBreak.fontDescriptor.symbolicTraits.contains(.traitBold) {
    // If bold after the first line break, then remove the attribute for the range after the break
    let rangeToClean = NSRange(location: firstLineBreakRange.location, length: effectiveRange.upperBound - firstLineBreakRange.location )
    textView.textStorage.removeAttribute(.font, range: rangeToClean)
    textView.textStorage.addAttribute(.font, value: noteFont(), range: rangeToClean)
    textView.typingAttributes = [.font: noteFont(), .foregroundColor: UIColor.label]
  }

  if firstLineBreakRange.lowerBound > 0 {
    let attributesBeforeFirstLineBreak = textView.attributedText.attributes(at: firstLineBreakRange.lowerBound - 1, effectiveRange: &effectiveRange)
    if let fontBeforeFirstLineBreak = attributesBeforeFirstLineBreak[.font] as? UIFont, !fontBeforeFirstLineBreak.fontDescriptor.symbolicTraits.contains(.traitBold) {
      // If not bold before the first line break, then remove the attribute for the range after the break
      let range = NSRange(location: 0, length: firstLineBreakRange.lowerBound)
      textView.textStorage.removeAttribute(.font, range: range)
        textView.textStorage.addAttribute(.font, value: titleFont(), range: range)
    }
  }
}
```
