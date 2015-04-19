class Blog
  attr_reader :articles
  attr_reader :last_update
  attr_reader :blog_url

  def initialize
    @articles = Array.new 

    articlesURLs = Dir["#{ARTICLES_DIRECTORY}**/*.md"]
    articlesURLs.each { |url| 
      next if url.include? "/drafts/"
      article = Article.new(url)
      @articles.push article 
    }

    @articles = @articles.sort_by {|x| x.date}
    @last_update = @articles.last.date

    @blog_url = BLOG_ROOT_URL
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
    log_string = 'Generating index: “' + template_url + '”'
    puts log_string.colorize(:blue)

    index_template = Haml::Engine.new(File.read(template_url), haml_options)
    index_output = index_template.render self
    index_output_path = template_url.gsub('.haml', '').gsub(TEMPLATES_DIRECTORY, RENDERED_DIRECTORY)
    FileUtils.mkdir_p(File.dirname(index_output_path))
    File.open(index_output_path, "w") do |file|
      file.write index_output
    end
  end

  def generate_index_year(year, haml_options)
    index = Index.new
    index.title = year.to_s
    index.articles = @articles.select { |a| a.date.year == year }

    log_string = 'Generating index year: “' + year.to_s + '” (' + index.articles.count.to_s + ' articles)'
    puts log_string.colorize(:light_blue)
    index.generate_index("templates/index-custom.html.haml", RENDERED_DIRECTORY+year.to_s+"/index.html", haml_options)
  end

  def generate_index_tag(tag, haml_options)
    index = Index.new
    index.title = tag
    index.articles = @articles.select { |a| a.keywords.include? tag }

    log_string = 'Generating index tag: “' + tag + '” (' + index.articles.count.to_s + ' articles)'
    puts log_string.colorize(:light_blue)
    tag_slug = tag.downcase.gsub(' ', '-')
    index.generate_index("templates/index-custom.html.haml", RENDERED_DIRECTORY+"tags/" + tag_slug + ".html", haml_options)
  end

  def generate_style(scss_name)
    puts 'Generating style: “' + scss_name + '”'
    style_input_url  = STYLES_DIRECTORY + scss_name
    style_output_url = RENDERED_DIRECTORY + STYLES_DIRECTORY + scss_name.gsub('.css.scss', '.css')

    FileUtils.mkdir_p(File.dirname(style_output_url))
    system("sass #{style_input_url} #{style_output_url}")
  end
end
