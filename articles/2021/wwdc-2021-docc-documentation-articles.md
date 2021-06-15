Title:     Notes WWDC 2021 : Elevate your DocC documentation in Xcode  
Author:    Vincent Tourraine  
Email:     me@vtourraine.net  
Date:      June 15, 2021  
Update:    
Keywords:  dev, Xcode  
Summary:   Mes notes pour la session « Elevate your DocC documentation in Xcode » de la WWDC 2021.  
Image:     
Language:  fr  


Mes notes pour la session [Elevate your DocC documentation in Xcode](https://developer.apple.com/videos/play/wwdc2021/10167) de la WWDC 2021.


## Page types

- Reference (code specific information)
- Articles (free-form content)
- Tutorials (step-by-step walkthrough)

Add “Documentation Catalog” to “Sources” folder

Images:

- Recommended to use @2x, with Dark Mode alternative
- Use `title~dark@2x.png` naming convention for files
- Reference the basic file name in Markdown (`![Desc](title.png)`)
 
## Organization

- Link to articles with `<doc:ArticleName>`
- Link to symbols with double backtick

## Extensions

Can put documentation in separate files, with same name (`Foo.swift` and `Foo.md`), and using the link syntax as title (`# ``Foo`` `)
