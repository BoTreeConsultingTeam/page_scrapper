require 'test_helper'
require_relative '../../app/exceptions/invalid_input_error'

class ScrapperTest < ActiveSupport::TestCase

  test "page with single occurrence of h1, h2, h3 and link tags" do
    content, friendly_params = get_page_content('single-tags.html')

    assert_not_empty content
    assert_equal 1, content[:h1].count
    assert_equal 1, content[:h2].count
    assert_equal 1, content[:h3].count
    assert_equal 1, content[:link].count
    assert_equal 4, friendly_params.count

    assert_equal 'H1 Heading', content[:h1].first
    assert_equal 'H2 Heading', content[:h2].last
    assert_equal 'H3 heading', content[:h3].last
    assert_equal 'http://www.botreetechnologies.com', content[:link].last

  end

  test "page with multiple h1, h2, h3 and links tags" do
    content, friendly_params = get_page_content('multiple-tags.html')

    assert_not_empty content
    assert_equal 1, content[:h1].count
    assert_equal 2, content[:h2].count
    assert_equal 2, content[:h3].count
    assert_equal 2, content[:link].count
    assert_equal 7, friendly_params.count

    assert_equal 'H1 Heading', content[:h1].first
    assert_equal 'Another H2 Heading', content[:h2].last
    assert_equal 'Another H3 heading', content[:h3].last
    assert_equal 'http://www.botreetechnologies.com/canvas-to-cloud', content[:link].last
  end

  test "page with no content" do
    content, friendly_params = get_page_content('blank.html')

    assert_not_empty content
    assert_equal 0, content[:h1].count
    assert_equal 0, content[:h2].count
    assert_equal 0, content[:h3].count
    assert_equal 0, content[:link].count
    assert_equal 0, friendly_params.count
  end

  test "for invalid link" do
    assert_raise ::InvalidInputError do
     Utilities::Scrapper.new('http://abc.xyz.eu').extract_page_contents
    end
  end

  EXAMPLE_URL = 'http://example/'
  private
    def html_page(file)
      uri = URI(EXAMPLE_URL)
      Mechanize::Page.new uri, nil, get_contents(file), 200, Mechanize.new
    end

    def mock_html_page(page)
      Mechanize.any_instance.stubs(:get).with(any_parameters).returns(html_page("test/fixtures/#{page}"))
    end

    def get_page_content(page)
      mock_html_page(page)
      scrapper = Utilities::Scrapper.new(EXAMPLE_URL)
      [scrapper.extract_page_contents, scrapper.friendly_params]
    end
end