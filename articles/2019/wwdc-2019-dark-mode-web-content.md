Title:     Notes WWDC 2019 : Supporting Dark Mode in Your Web Content  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 11, 2019  
Update:    
Keywords:  dev, macOS, iOS, web  
Summary:   Mes notes pour la session 511 de la WWDC 2019 : Supporting Dark Mode in Your Web Content.  
Image:     
Language:  fr  


Référence : [Session 511 - Supporting Dark Mode in Your Web Content](https://developer.apple.com/wwdc19/511)


Dark Mode supported in:
- Safari
- Mail
- Apps with web view
- Other web browsers (specification pending)

## Dark Mode in web content

Let the rendering engine know that both styles are supported, and changes the default text and background colors:

``` css
:root {
  color-scheme: light dark;
} 
```

Use CSS variables to adapt to Dark Mode, with media queries:

``` css
:root {
  color-scheme: light dark;
  --post-title-color: #333;
}

@media (prefers-color-scheme: dark) {
  :root {
    --post-title-color: white;
  }
}

h1 {
  color: var(--post-title-color);
}
```

For images:

``` html
<picture>
  <source srcset="night.jpg" media="(prefers-colour-scheme: dark)">
  <img src="day.jpg">
</picture>
```

## Dark Mode in email messages
- Auto Dark Mode for “simple” messages (plain text?)
- Rich messages with remote images use light color scheme
- Use `color-scheme` and `prefers-color-scheme` for customization

## Tools to debug Dark Mode
- New color scheme toggle in web inspector
