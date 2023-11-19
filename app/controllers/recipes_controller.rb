class RecipesController < ApplicationController
    before_action :set_recipe, only: [:show, :edit, :update, :destroy]

    def index
        @recipes = Recipe.all
    end

    def show
    end

    def public_recipe
        @recipe_public = Recipe.where(public: true)
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = Recipe.new(recipe_params)
        if @recipe.save
        redirect_to @recipe, notice: 'Recipe was successfully created.'
        else
        render :new
        end
    end

    private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end

end
