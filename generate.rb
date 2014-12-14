#!/usr/bin/env ruby

# WoD

require "rubygems"
require "bundler/setup"

require "fileutils"

require "haml"
require "date"

require_relative "blog"
require_relative "article"

ARTICLES_DIRECTORY  = "articles/"
TEMPLATES_DIRECTORY = "templates/"
ASSETS_DIRECTORY    = "assets/"
STYLES_DIRECTORY    = "styles/"
RENDERED_DIRECTORY  = "rendered/"

BLOG_ROOT_URL = "http://www.vtourraine.net/blog/"

MONTHS_FR = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']

puts 'Generating Blog'

haml_options = { attr_wrapper: '"', format: :html5 }
article_template = Haml::Engine.new(File.read("./templates/article.html.haml"), haml_options)

blog = Blog.new

blog.clean

blog.copy_assets

blog.articles.each { |article|
  article.generate article_template, haml_options
}

blog.generate_index "templates/index.html.haml",    haml_options
blog.generate_index "templates/feed.xml.haml",      haml_options
blog.generate_index "templates/articles.json.haml", haml_options

blog.generate_style "default.css.scss"

puts "Ready! (#{blog.articles.count} articles)"
