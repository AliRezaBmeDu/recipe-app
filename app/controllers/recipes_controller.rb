class RecipesController < ApplicationController
    before_action :set_recipe, only: [:show]

    def index
        @recipes = current_user.recipes
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

    def toggle_public
      @recipe = Recipe.find(params[:id])
      @recipe.change_public_status
      redirect_to recipe_specific_path(recipe_id: @recipe.id), notice: 'Recipe status has changed.'
    end

    def destroy
      @recipe = current_user.recipes.find(params[:id])
  
      if @recipe.destroy
        redirect_to recipes_path, notice: 'Recipe deleted successfully'
      else
        redirect_to recipes_path, notice: 'Recipe cannot delete'
      end
    end

    private

  def set_recipe
    @recipe = Recipe.includes(:recipe_foods, :foods).find(params[:recipe_id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end

end
