Rails.application.routes.draw do
  devise_for :users, path: 'auth'

  get '/users', to: 'users#index', as: :users
  get '/general_shopping_list', to: 'users#shopping_list', as: :general_shopping_list
  get '/foods', to: 'foods#index', as: :foods
  get '/recipes', to: 'recipes#index', as: :recipes
  get '/recipes/:recipe_id', to: 'recipes#show', as: :recipe_specific
  get '/public_recipes', to: 'recipes#public_recipe', as: :public_recipe
  post '/users/:user_id/foods', to: 'foods#create', as: :add_new_food

  resources :users, only: [:index, :show, :new] do
    resources :foods, except: [:update, :edit]
    resources :recipes, except: [:update, :edit] do
      member do
        put :toggle_public
      end
      resources :recipe_foods, only: [:index, :new, :create, :destroy]
    end
  end

  authenticated :user do
    root to: 'recipes#public_recipe', as: :authenticated_root
  end

  devise_scope :user do
    root to: "devise/sessions#new", as: :sign_in_root
  end
end
