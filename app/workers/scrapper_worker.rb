class ScrapperWorker

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(url)
    if url.present?
      page_scrapping_util = ::Utilities::Scrapper.new(url)
      scrapped_data = page_scrapping_util.extract_page_contents rescue nil

      @page = Page.create(url: url)
      scrapped_data.each do |scrapped_elements|
        if scrapped_elements.last.present?
          @page.page_contents.create(
                                      tag_type: PageContent.tag_types[scrapped_elements.first],
                                      tag_content: scrapped_elements.last
                                    )
        end
      end
      puts 'Successful completion!'
    else
      puts 'No url was passed!'
    end
  end
end