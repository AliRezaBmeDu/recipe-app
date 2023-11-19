class RecipesController < ApplicationController

    def index
        @recipes = Recipe.all
    end

    def show
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
end
