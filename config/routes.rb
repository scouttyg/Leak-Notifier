Rails3BootstrapDeviseCancan::Application.routes.draw do
  authenticated :user do
    root :to => "users#dashboard"
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index, :dashboard]
end
