
Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  get 'welcome/index'
 
  resources :books
 
  root 'welcome#index'
end
