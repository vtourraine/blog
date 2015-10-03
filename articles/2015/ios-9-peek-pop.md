Title:     Comment implémenter Peek et Pop pour 3D Touch  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      October 3, 2015  
Update:    
Keywords:  iOS, UIKit, dev  
Summary:   Tous les ans c’est la même chose, Apple garde quelques API en surprise pour la sortie d’iOS au mois de septembre. Avec iOS 9 et les écrans 3D Touch des nouveaux iPhones, voici donc « Peek » et « Pop », qui remportent conjointement le prix de l’API au nom le plus ridicule à porter. Du côté du code, par contre, il est question de « view controller previewing » et de « commit » du preview, le tout restant associé à Force Touch.  
Image:     http://www.vtourraine.net/blog/img/2015/ios-9-peek-pop/3d-touch-video.jpg  
Thumbnail: http://www.vtourraine.net/blog/img/2015/ios-9-peek-pop/thumbnail-3d-touch-video.jpg  
Language:  fr  


Tous les ans c’est la même chose, Apple garde quelques API en surprise pour la sortie d’iOS au mois de septembre.

Avec iOS 9 et les écrans 3D Touch des nouveaux iPhones, voici donc « Peek » et « Pop », qui remportent conjointement le prix de l’API au nom le plus ridicule à porter. Du côté du code, par contre, il est question de « view controller previewing » et de « commit » du preview, le tout restant associé à Force Touch.

Concrètement, il s’agit d’un moyen alternatif pour présenter un view controller, en appuyant légèrement sur un élément pour prévisualiser l’action associée (_Peek_), et en appuyant plus fort pour confirmer (_Pop_). 

![3D Touch, image [apple.com](http://apple.com)][3D Touch video]

Ça n’a rien d’essentiel, mais cette nouvelle interaction possède à mes yeux un avantage de taille : pouvoir visualiser puis faire disparaître une vue avec un unique contact de l’écran. Plutôt que d’appuyer une première fois pour présenter, puis une seconde fois pour revenir, tout se fait en fonction de la pression appliquée en un seul _tap_. La différence est importante compte tenu de l’augmentation de la taille des iPhones. Inutile d’aller chercher le bouton “Retour” tout en haut à gauche de l’écran, inutile de tenter un geste depuis le bord gauche : il suffit de relever le doigt. Bref, ça peut être intéressant à implémenter.

Pour ne rien gâcher, l’API est très simple, et ne devrait pas modifier grand chose à votre code existant. Voici un exemple de mise en place, étape par étape.


## Enregistrement

On commence par enregistrer la vue concernée, en vérifiant la compatibilité 3D/Force Touch. Un appel dans `viewDidLoad` suffit, le dé-enregistrement sera pris en charge automatiquement lors du `dealloc`.

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

Petite précision, `forceTouchCapability` est une nouveauté du SDK iOS 9, il faudra donc tester sa disponibilité pour des apps supportant les versions d’iOS antérieures.

``` objc
// Pour iOS 8+
if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)] &&
    self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
}

// Pour iOS 7+
if ([self respondsToSelector:@selector(traitCollection)] &&
    [self.traitCollection respondsToSelector:@selector(forceTouchCapability)] &&
    self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
}
```


## Peek preview

Quand l’utilisateur appuie sur l’écran, le delegate est chargé de créer le view controller à prévisualiser. Il n’y a aucune modification à apporter au controller en question, on se contente de l’initialiser et de le configurer comme d’habitude (Storyboard, code, peu importe). La seule addition consiste à indiquer le cadre de la vue ainsi sélectionnée, pour permettre à UIKit d’ajouter l’effet de flou correspondant.

Voilà ce que ça donne pour un `UITableViewController`, en cherchant la cellule sélectionnée à partir de la position de l’évènement.

``` objc
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
  NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

  if (!indexPath || !cell) {
    return nil;
  }

  previewingContext.sourceRect = cell.frame;

  DetailsViewController *detailsViewController = // …

  return detailsViewController;
}
```


## Pop commit

Le _Pop_ est une simple formalité, où il suffit généralement pour le delegate de présenter le view controller créé ci-dessus.

``` objc
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
  [self showViewController:viewControllerToCommit sender:self];
}
```

Le tour est joué, votre view controller peut maintenant prévisualiser et confirmer la navigation.


## En bonus, les Actions

Pour aller un peu plus loin, vous avez la possibilité de renseigner des actions de prévisualisation. Elles se présentent en dessous de l’aperçu, et se révèlent si l’utilisateur déplace son doigt vers le haut de l’écran.

Ces actions sont associées au view controller présenté, indifféremment de celui qui présente (à la différence du code décrit jusqu’à présent). Il s’agit donc d’y implémenter la méthode `previewActionItems`, retournant un tableau d’objets se conformant à `UIPreviewActionItem`. Le plus raisonnable consiste à retenir ce tableau dans une propriété pour être réutilisé à la demande (_lazy loading_), car cette méthode est visiblement appelée à chaque mouvement du doigt (beaucoup d’appels pour retourner toujours la même chose).

``` objc
@property (nonatomic, strong, nullable) NSArray <id <UIPreviewActionItem>> *previewActions;

// …

- (NSArray <id <UIPreviewActionItem>> *)previewActionItems {
  if (!self.previewActions) {
    self.previewActions =
    @[[UIPreviewAction
       actionWithTitle:NSLocalizedString(@"...", nil)
       style:UIPreviewActionStyleDefault
       handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
         // …
       }]];
  }

  return self.previewActions;
}
```


## Exemple

J’avais envie de tester cette API sur un projet relativement simple, et [l’application Mix-IT](https://itunes.apple.com/app/mix-it/id982003173?ls=1&mt=8) publiée cette année convenait parfaitement (un table view controller, et un view controller pour le détail). Comme le projet est par ailleurs open source, vous pouvez voir ce que ça donne, dans son ensemble, [sur GitHub](https://github.com/vtourraine/mixit/blob/master/mixit/Classes/AMGTalksViewController.m). 

<video controls="controls" width="268" height="480">
  <source src="http://www.vtourraine.net/blog/img/2015/ios-9-peek-pop/3d-touch-previewing-480.mov"></source>
  Votre navigateur ne peut pas afficher cette vidéo.
</video>

La seule difficulté consistait à prendre en compte le search display controller qui se superpose à la table view principale. Ma solution consiste à garder une propriété pour le contexte de prévisualisation, et ainsi dé-enregistrer/ré-enregistrer la vue adéquate sur les évènements de présentation du search display controller. Si vous avez une meilleure approche, je suis preneur.


## Documentation

- [3D Touch - iOS Developer](https://developer.apple.com/ios/3d-touch/)
- [_ViewControllerPreviews_ - Sample Code](https://developer.apple.com/library/ios/samplecode/ViewControllerPreviews/)
- [`UIPreviewAction` Class Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPreviewAction_Class/)
- [`UIPreviewActionGroup` Class Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPreviewActionGroup_Class/)
- [`UIPreviewActionItem` Protocol Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPreviewActionItem_Protocol/)

![3D Touch, image [apple.com](http://apple.com)][3D Touch hero]

[3D Touch hero]: http://www.vtourraine.net/blog/img/2015/ios-9-peek-pop/3d-touch-hero.jpg
[3D Touch video]: http://www.vtourraine.net/blog/img/2015/ios-9-peek-pop/3d-touch-video.jpg
