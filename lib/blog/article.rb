class Article
  attr_reader :url
  attr_reader :title
  attr_reader :date
  attr_reader :keywords
  attr_reader :summary
  attr_reader :image_url
  attr_reader :body

  attr_reader :blog_url

  def initialize(url)
    @url   = url
    @title     = `multimarkdown -e title #{@url}`.lines.first.chomp
    @summary   = `multimarkdown -e summary #{@url}`.lines.first.chomp
    @date      = Date.parse `multimarkdown -e date #{@url}`.lines.first.chomp
    @keywords  = `multimarkdown -e keywords #{@url}`.lines.first.chomp.split(', ')
    @image_url = `multimarkdown -e image #{@url}`.lines.first.chomp
    @body      = `multimarkdown --snippet #{@url}`

    @blog_url = BLOG_ROOT_URL
  end

  def disqus_url
    BLOG_ROOT_URL + File.basename(@url, File.extname(@url))
  end

  def web_url
    BLOG_ROOT_URL + @url.gsub(ARTICLES_DIRECTORY, '').gsub('.md', '')
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
