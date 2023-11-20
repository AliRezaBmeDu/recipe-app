Rails.application.routes.draw do
  get '/users', to: 'users#index', as: :users
  get '/foods', to: 'foods#index', as: :foods
  get '/recipes', to: 'recipes#index', as: :recipes
  get '/recipes/:recipe_id', to: 'recipes#show', as: :recipe_specific
  get '/public_recipes', to: 'recipes#public_recipe', as: :public_recipe
  get '/general_shopping_list', to: 'shopping#general_list', as: :general_shopping_list
  root "users#index"
end
