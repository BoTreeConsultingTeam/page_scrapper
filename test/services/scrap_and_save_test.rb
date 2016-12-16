require 'test_helper'

class ScrapAndSaveTest < ActiveSupport::TestCase
  EXAMPLE_URL = 'http://example/'

  test 'scrap and save content' do
    Utilities::Scrapper.any_instance.stubs(:extract_page_contents).with(any_parameters).returns({})
    Utilities::Scrapper.any_instance.stubs(:friendly_params).with(any_parameters).returns(fixture_data)
    page = ScrapAndSave.new(EXAMPLE_URL).call

    assert_equal EXAMPLE_URL, page.url
    assert_equal 4, page.page_contents.count
    assert_equal PageContent.tag_types.keys, page.page_contents.pluck(:tag_type)
  end

  private
    def fixture_data
      [
        { tag_type: 'h1', tag_content: 'H1 Heading' },
        { tag_type: 'h2', tag_content: 'H2 Heading' },
        { tag_type: 'h3', tag_content: 'H3 Heading' },
        { tag_type: 'link', tag_content: 'http://www.botreetechnologies.com' },
      ]
    end
end