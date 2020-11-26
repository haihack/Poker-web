Rails.application.routes.draw do
  get 'welcome/index'
  post 'welcome/checkHand'
  root 'welcome#index'
end
