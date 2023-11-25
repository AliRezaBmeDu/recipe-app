class RecipesController < ApplicationController
    before_action :set_recipe, only: [:show]

    def index
        @recipes = Recipe.all
    end

    def show
    end

    def public_recipe
        @recipe_public = Recipe.where(public: true)
    end

    def new
        @user = current_user
        @recipe = @user.recipes.new
    end

    def create
        @user = current_user
        @recipe = @user.recipes.new(recipe_params)
        
        if @recipe.save
          redirect_to recipe_specific_path(recipe_id: @recipe.id), notice: 'Recipe was successfully created.'
        else
          render :new
          puts 'Error in saving'
        end
    end

    private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end

end
