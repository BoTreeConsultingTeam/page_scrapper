Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      post 'scrapper' => 'page_scrapper#create'
      get 'scrapper' => 'page_scrapper#index'
    end
  end
end
