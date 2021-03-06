# WoD/Blog vtourraine

_WoD is a very simple static blog CMS; powered by MultiMarkdown/Haml/Sass._

This is the engine and content for [my blog](http://www.vtourraine.net/blog/).


## How to set up

1. Install MultiMarkdown
  * you can use the [official Mac Installer](http://fletcherpenney.net/multimarkdown/download/)
  * or homebrew: `brew install multimarkdown`
2. Install Sass (you can follow the [instructions on the Sass website](http://sass-lang.com/install); later, this will be merged into the next step)
3. Run the Bundler installation command:

```
bundle
```

## How to use

Simply write your articles as `.md` files in the `/articles` directory.

Then generate your blog:

    rake



## License

All code is published under the [MIT License](http://opensource.org/licenses/MIT).

All content is released under the [Creative Commons BY-NC License](http://creativecommons.org/licenses/by-nc/4.0/).
