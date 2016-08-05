require 'test_helper'

class Api::V1::PageScrapperControllerTest < ActionController::TestCase
  
  setup do
    set_as_json_request
  end
  
  test "scrape_url should render 'Url cannot be blank!' when url is empty" do
    post :create,  { url: ''}
    assert_equal 'Url cannot be blank!', json_response[:error]
  end

  test "create should render invalid Url when url is invalid" do
    post :create, {url: 'hfdytfhgfhgfhvf'}
    assert_equal 'Invalid Url!', json_response[:error]
  end

  test "scrape url should return invalid url." do
    post :create, { url: 'http://asassdsd.com'}
    assert_equal 'Invalid url', json_response[:error]
  end
  
  test "returns all urls with their data h1,h2,h3 and link when url is valid" do
    page = pages(:one)
    get :index
    assert_response :success
    assert_equal 2, json_response.size
    first_page = json_response.first
    assert_equal page.url, first_page.keys[0].to_s
    assert_equal page.page_contents.h1[0].tag_content, first_page.values[0][:h1][0]
    assert_equal page.page_contents.h2[0].tag_content, first_page.values[0][:h2][0]
    assert_equal page.page_contents.h3[0].tag_content, first_page.values[0][:h3][0]
    assert_equal page.page_contents.link[0].tag_content, first_page.values[0][:link][0]
  end
  
  test "scrape url should fetch url data h1,h2,h3 and link when url is valid" do
    assert_difference('Page.count', 1, "Page should created.") do
      post :create, { url: 'http://www.w3schools.com/html/html_attributes.asp'}
    end  
    assert_response :success
    assert_equal 'http://www.w3schools.com/html/html_attributes.asp', json_response.keys[0].to_s
    assert json_response.values[0][:h1].present?
    assert json_response.values[0][:h2].present?
    assert json_response.values[0][:h3].present?
    assert json_response.values[0][:link].present?
  end
  
  test "scrape url should not fetch url data h1,h2,h3 and link when url is already scrapped" do
    page = pages(:one)
    assert_difference('Page.count', 0, "Page should created.") do
      post :create, { url: page.url}
    end  
    assert_response :success
    assert_equal "Url is already scrapped!", json_response[:error]
  end

end
