class RecipeFoodsController < ApplicationController
  def new
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.all
    @recipe_food = @recipe.recipe_foods.new
  end

  def create
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_specific_path(recipe_id: @recipe.id), notice: 'Ingredient added successfully'
    else
      render :new, notice: 'Error to add ingredient'
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])

    if @recipe_food.destroy
      redirect_to recipe_specific_path(recipe_id: @recipe_food.recipe), notice: 'Ingredient removed successfully'
    else
      redirect_to root, notice: 'Ingredient cannot remove'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:recipe_id, :food_id, :quantity)
  end
end
