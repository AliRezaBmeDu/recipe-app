Rails.application.routes.draw do
  devise_for :users, path: 'auth'
  
  get '/users', to: 'users#index', as: :users
  get '/foods', to: 'foods#index', as: :foods
  get '/recipes', to: 'recipes#index', as: :recipes
  get '/recipes/:recipe_id', to: 'recipes#show', as: :recipe_specific
  get '/public_recipes', to: 'recipes#public_recipe', as: :public_recipe
  get '/general_shopping_list', to: 'shopping#general_list', as: :general_shopping_list
  root "users#index"

  authenticated :user do
    root to: 'users#index', as: :authenticated_root
  end

  devise_scope :user do
    root to: "devise/sessions#new", as: :sign_in_root
  end
end
