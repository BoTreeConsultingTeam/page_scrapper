module Utilities
  class Scrapper
    attr_accessor :url, :page, :content

    def initialize(url)
      self.url = url
    end

    def extract_page_contents
      agent = Mechanize.new
      self.page = agent.get(url)

      self.content = {
          h1: header_contents('h1'),
          h2: header_contents('h2'),
          h3: header_contents('h3'),
          link: page.links.inject([]) { |all, link| all << link.href; all }.uniq
      }
    rescue
      raise InvalidInputError.new('Invalid url')
    end

    def friendly_params
      params = []
      content.each do |tag, tag_values|
        tag_values.each do |tag_value|
          params << { tag_type: tag, tag_content: tag_value }
        end
      end
      params
    end

    private
      def header_contents(tag)
        page.search(tag).inject([]) { |all, header| all << header.text; all }
      end
  end
end