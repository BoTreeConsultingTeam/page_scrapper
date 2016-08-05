class Api::V1::PageScrapperController < ApplicationController
  respond_to :json

  skip_before_filter  :verify_authenticity_token

  REGEX_URL = /^((http|https):\/\/)+(www\.)*[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?/

  before_filter :is_valid_url?, only: :create

  def create
    @page = ScrapAndSave.new(params[:url]).call
  end

  def index
    @pages = Page.all.includes(:page_contents)
  end

  private
    def is_valid_url?
      if params[:url].blank?
        error_msg = 'Url cannot be blank!'
      else
        error_msg = 'Invalid Url!'  if REGEX_URL.match(params[:url]).nil?
      end
      render json: { error: error_msg }, status: 422 and return false if error_msg
    end
end
