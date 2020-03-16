class Index
  attr_accessor :articles
  attr_accessor :title
  attr_reader :blog_url
  attr_accessor :page_path

  def initialize
    @articles = Array.new 
    @blog_url = BLOG_ROOT_URL
  end

  def generate_index(template_url, output_url, haml_options)
    index_template = Haml::Engine.new(File.read(template_url), haml_options)
    index_output = index_template.render self
    FileUtils.mkdir_p(File.dirname(output_url))
    File.open(output_url, "w") do |file|
      file.write index_output
    end
  end
end
