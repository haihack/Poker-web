Rails.application.routes.draw do
  get 'welcome/index'
  post 'welcome/checkHand'
  match '/curl_example' => 'welcome/index#curl_post_example', via: :post
  root 'welcome#index'
end
