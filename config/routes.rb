Rails.application.routes.draw do
  
  get "home" => "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  root "static_pages#home"

  namespace :admins do
    resources :subjects
  end
end
