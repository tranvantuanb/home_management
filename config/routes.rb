Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations",
    sessions: "sessions"}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  resources :users
  namespace :admin do
    root "admins#index", as: :root
    resources :costs, :floors, :floor_costs
    resources :users do
      get "get_user_cost_info", on: :collection
    end
    resources :statistic
  end
end
