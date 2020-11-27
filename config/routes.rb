Rails.application.routes.draw do
  get 'welcome/index'
  post 'welcome/check_hand'
  root 'welcome#index'
end
