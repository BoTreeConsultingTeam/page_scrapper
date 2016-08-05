class ScrapAndSave
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def call
    scrapper = Utilities::Scrapper.new(url)
    scrapper.extract_page_contents
    Page.create(url: url, page_contents_attributes: scrapper.friendly_params)
  end
end