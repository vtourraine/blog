#!/usr/bin/env ruby

# WoD

require "rubygems"
require "bundler/setup"

require "fileutils"

require "haml"
require "date"


ARTICLES_DIRECTORY  = "articles/"
TEMPLATES_DIRECTORY = "templates/"
ASSETS_DIRECTORY    = "assets/"
STYLES_DIRECTORY    = "styles/"
RENDERED_DIRECTORY  = "rendered/"

MONTHS_FR = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']

class Blog
  attr_reader :articles

  def initialize
    @articles = Array.new 

    articlesURLs = Dir["#{ARTICLES_DIRECTORY}**/*.md"]
    articlesURLs.each { |url| 
      article = Article.new(url)
      @articles.push article 
    }

    @articles = @articles.sort_by {|x| x.date}
  end

  def clean
    puts 'Cleaning'
    system("rm -r #{RENDERED_DIRECTORY}*")
  end

  def copy_assets
    puts 'Copying assets'
    system("cp -r #{ASSETS_DIRECTORY}* #{RENDERED_DIRECTORY}")
  end

  def generate_index(template_url, haml_options)
    puts 'Generating index: “' + template_url + '”'

    index_template = Haml::Engine.new(File.read(template_url), haml_options)
    index_output = index_template.render self
    index_output_path = template_url.gsub('.html.haml', '.html').gsub(TEMPLATES_DIRECTORY, RENDERED_DIRECTORY)
    File.open(index_output_path, "w") do |file|
      file.write index_output
    end
  end

  def generate_style(scss_name)
    puts 'Generating style: “' + scss_name + '”'
    style_input_url  = STYLES_DIRECTORY + scss_name
    style_output_url = RENDERED_DIRECTORY + STYLES_DIRECTORY + scss_name.gsub('.css.scss', '.css')

    FileUtils.mkdir_p(File.dirname(style_output_url))
    system("sass #{style_input_url} #{style_output_url}")
  end
end

class Article
  attr_reader :url
  attr_reader :title
  attr_reader :date
  attr_reader :keywords
  attr_reader :summary
  attr_reader :body

  def initialize(url)
    @url   = url
    @title    = `multimarkdown -e title #{@url}`.lines.first.chomp
    @summary  = `multimarkdown -e summary #{@url}`.lines.first.chomp
    @date     = Date.parse `multimarkdown -e date #{@url}`.lines.first.chomp
    @keywords = `multimarkdown -e keywords #{@url}`.lines.first.chomp.split(', ')
    @body     = `multimarkdown --snippet #{@url}`
  end

  def disqus_url
    "http://www.vtourraine.net/blog/" + File.basename(@url, File.extname(@url))
  end

  def locale_date
    @date.strftime '%-d ' + MONTHS_FR[@date.month - 1] + ' %Y'
  end

  def generate(article_template, haml_options)
    puts 'Generating: “' + @title + '”'

    output = article_template.render self

    output_raw_path = @url.gsub(ARTICLES_DIRECTORY, RENDERED_DIRECTORY)
    output_path     = @url.gsub(ARTICLES_DIRECTORY, RENDERED_DIRECTORY).gsub('.md', '.html')

    FileUtils.mkdir_p(File.dirname(output_raw_path))
    FileUtils.cp @url, output_raw_path

    File.open(output_path, "w") do |file|
      file.write output
    end
  end
end

puts 'Generating Blog'

haml_options = { attr_wrapper: '"', format: :html5 }
article_template = Haml::Engine.new(File.read("./templates/article.html.haml"), haml_options)

blog = Blog.new

blog.clean

blog.copy_assets

blog.articles.each { |article|
  article.generate article_template, haml_options
}

blog.generate_index "templates/index.html.haml", haml_options
blog.generate_style "default.css.scss"

puts "Ready! (#{blog.articles.count} articles)"
