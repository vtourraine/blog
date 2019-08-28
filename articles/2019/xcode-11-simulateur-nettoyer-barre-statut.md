Title:     Nettoyer la barre de statut du Simulateur avec Xcode 11  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      August 28, 2019  
Update:    
Keywords:  dev, iOS  
Summary:   Les captures d’écran sont incontournables sur l’App Store. Elles sont obligatoires pour publier une application, mais surtout elles sont importantes pour communiquer avec un futur utilisateur potentiel, et le convaincre d’installer l’application.  
Image:     https://www.vtourraine.net/blog/img/2019/xcode-11-simulateur-nettoyer-barre-statut/clean-status-bar.png  
Language:  fr  


Les captures d’écran sont incontournables sur l’App Store. Elles sont obligatoires pour publier une application, mais surtout elles sont importantes pour communiquer avec un futur utilisateur potentiel, et le convaincre d’installer l’application.

Les détails comptent, et pour les captures d’écran, cela commence par une barre de statut propre. Ce n’est pas un hasard si tous les screenshots sur [apple.com](https://www.apple.com/iphone/) affichent la même barre. « 9:41 », réception cellulaire au maximum, réception wifi au maximum, et batterie pleine. Tout autre arrangement serait distrayant, et donc nuisible. Vous avez tout intérêt à faire la même chose pour vos applications, sur l’App Store et ailleurs.

![Barre de statut nettoyée](/blog/img/2019/xcode-11-simulateur-nettoyer-barre-statut/clean-status-bar.png)

Jusqu’à maintenant, [Simulator Status Magic](https://github.com/shinydevelopment/SimulatorStatusMagic) était la solution la plus directe. Ce projet, créé par Dave Verwer, invoque quelques API privées du Simulateur pour forcer les paramètres concernés. **Avec Xcode 11, Apple propose enfin une solution officielle pour configurer la barre de statut du Simulateur en ligne de commande.**

```
xcrun simctl status_bar <device> override --time "9:41" --batteryState charged --batteryLevel 100 --cellularBars 4
```

Il suffit d’exécuter cette commande pour voir le Simulateur en question se mettre à jour immédiatement.

## Configurer avec Xcode beta

Si vous avez uniquement Xcode 11 installé sur votre machine, tout va bien.

Si vous avez plusieurs versions d’Xcode installées, typiquement avec une version stable et une version beta, il faut d’abord utiliser `xcode-select` pour préciser la version concernée. Pour passer à la beta Xcode 11, par exemple :

``` txt
sudo xcode-select -s "/Applications/Xcode-beta.app/Contents/Developer"
```

Et n’oubliez pas à la fin de repasser sur la version stable :

``` txt
sudo xcode-select -s "/Applications/Xcode.app/Contents/Developer"
```

## Trouver le bon device

La configuration prend en paramètre l’identifiant d’un « device », ce qui correspond à l’un des Simulateurs listés par Xcode. Commencez par lister les devices disponibles :

``` txt
xcrun simctl list devices
```

Vous obtenez une liste comme celle-ci :

``` txt
== Devices ==
(...)
-- iOS 13.0 --
    iPhone 8 (7B33E6F6-1CF0-4BE5-A6C4-736C2B8FF348) (Shutdown) 
    iPhone 8 Plus (DF405AA7-73E3-472D-BE02-9D38DE416E07) (Shutdown) 
    iPhone Xs (3F72914D-525D-4C41-9414-016E7F276F62) (Shutdown) 
    iPhone Xs Max (4C2F9E99-3D13-48AE-B3CD-DD4D4DE91C6A) (Shutdown) 
    iPhone Xʀ (8FF15C5B-BDB2-4B9B-BF55-A1D5D46095C3) (Booted) 
    iPad Pro (9.7-inch) (79DADC11-39FE-4F7E-B2C2-14315400F1ED) (Shutdown) 
    iPad Pro (11-inch) (8D151B23-580F-4E03-B994-D4736211E72A) (Shutdown) 
    iPad Pro (12.9-inch) (3rd generation) (B42F7A37-5F53-41FB-ADD8-236EFE201B1C) (Shutdown) 
    iPad Air (3rd generation) (BC34DEEB-4DB9-4A3D-91B9-8E002ECBF83C) (Shutdown) 
(...)
```

Il ne reste plus qu’à utiliser l’identifiant du device qui vous intéresse. Par exemple, ici pour l’iPhone XR :

``` txt
xcrun simctl status_bar 8FF15C5B-BDB2-4B9B-BF55-A1D5D46095C3 override --time "9:41" --batteryState charged --batteryLevel 100 --cellularBars 4
```

## Documentation

> **Set or clear status bar overrides**
>
> Usage: `simctl status_bar <device> [list | clear | override <override arguments>]`
> 
> Supported Operations:
> - `list` List existing overrides.
> - `clear` Clear all existing status bar overrides.
> - `override <override arguments>` Set status bar override values, according to these flags.
> 
> You may specify any combination of these flags (at least one is required):
> - `--time <string>` Set the date or time to a fixed value. If the string is a valid ISO date string it will also set the date on relevant devices.
> - `--dataNetwork <dataNetworkType>` If specified must be one of `wifi`, `3g`, `4g`, `lte`, `lte-a`, or `lte+`.
> - `--wifiMode <mode>` If specified must be one of `searching`, `failed`, or `active`.
> - `--wifiBars <int>` If specified must be 0-3.
> - `--cellularMode <mode>` If specified must be one of `notSupported`, `searching`, `failed`, or `active`.
> - `--cellularBars <int>` If specified must be 0-4.
> - `--batteryState <state>` If specified must be one of `charging`, `charged`, or `discharging`.
> - `--batteryLevel <int>` If specified must be 0-100.
