# Comment implémenter Peek et Pop pour 3D Touch

// tags: iOS, Objectice-C, UIKit, dev


Tous les ans c’est la même chose, Apple garde quelques API en surprise pour la mise à jour d’iOS du mois de septembre.

Avec iOS 9 et les écrans “3D Touch” des nouveaux iPhones, voici donc _Peek_ et _Pop_, qui remportent le prix du nom le plus ridicule à porter. Du côté de l’API, il s’agit de “view controller previewing” et de “commit” du preview.

Concrètement, il s’agit d’un moyen alternatif pour présenter un view controller, en appuyant légèrement sur un élément pour pré-visualiser l’action associée (“peek”), et en appuyant plus fort pour confirmer (“pop”). 

Ça n’a rien d’essentiel, mais cette nouvelle interaction possède à mes yeux un avantage de taille : pouvoir visualiser puis faire disparaître une vue avec un unique contact sur l’écran. Plutôt que d’appuyer une première fois pour présenter, puis une seconde fois pour revenir, tout se fait à partir de la pression appliquée en un seul _tap_. Inutile d’aller chercher le bouton “Retour” tout en haut à gauche d’écran, inutile de tenter un geste depuis le bord gauche, il suffit de relever le doigt. Bref, ça peut être intéressant à implémenter.

Pour ne rien gâcher, l’API est très simple, et ne devrait pas modifier grand chose à votre code existant. Voici un exemple de mise en place, étape par étage.


## Enregistrement

On commence par enregistrer la vue concernée, en vérifiant la compatibilité 3D _Force_ Touch. Un appel dans `viewDidLoad` suffit, le dé-enregistrement sera pris en charge automatiquement lors du `dealloc`.

``` objc
@interface ViewController () <UIViewControllerPreviewingDelegate>
@end

// …

- (void)viewDidLoad {
  [super viewDidLoad];

  if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
  } 
}
```

## Preview

Quand l’utilisateur appuie sur l’écran, le delegate est chargé de créer le view controller à pré-visualiser. Il n’y a aucune modification à apporter au controller en question, on se contente de l’initialiser et de le configurer comme d’habitude (Storyboard, code, peu importe). La seule addition consiste à indiquer le frame de la vue ainsi sélectionnée, pour permettre à UIKit d’ajouter l’effet de flou correspondant.

Même pour un `UITableViewController`, le résultat est assez trivial.

``` objc
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
  NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

  if (!indexPath || !cell) {
    return nil;
  }

  previewingContext.sourceRect = cell.frame;

  DetailsViewController *detailsViewController = //…
  return detailsViewController;
}
```


## Commit

Le _pop_ est une simple formalité, où il suffit généralement pour le delegate de présenter le view controller créé ci-dessus.

``` objc
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
  [self showViewController:viewControllerToCommit sender:self];
}
```


## En bonus, les Actions

## Exemple

## Documentation

- [3D Touch - iOS Developer](https://developer.apple.com/ios/3d-touch/)
- [_ViewControllerPreviews_ - Sample Code](https://developer.apple.com/library/ios/samplecode/ViewControllerPreviews/)
- [`UIPreviewAction` Class Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPreviewAction_Class/)
- [`UIPreviewActionGroup` Class Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPreviewActionGroup_Class/)
- [`UIPreviewActionItem` Protocol Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPreviewActionItem_Protocol/)
