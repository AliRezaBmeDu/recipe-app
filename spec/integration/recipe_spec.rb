require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  before(:each) do
    @user = User.create(name: 'tom', email: 'tom@example.com', password: '1234567890',
                        password_confirmation: '1234567890')
    @recipe = Recipe.create(name: 'Egg Fry', preparation_time: 1, cooking_time: 3, description: 'Oil and salt',
                            public: true, user_id: @user.id)
    @food = Food.create(name: 'Egg', measurement_unit: 'units', price: 1, quantity: 50, user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 20, food_id: @food.id, recipe_id: @recipe.id)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  describe 'Test for recipe' do
    it 'create a new recipe' do
      visit new_user_recipe_path(@user)
      fill_in 'Name', with: @recipe.name
      fill_in 'Preparation time', with: @recipe.preparation_time
      fill_in 'Cooking time', with: @recipe.cooking_time
      fill_in 'Description', with: @recipe.description
      click_button 'Create Recipe'
      expect(page).to have_text('Egg Fry')
    end

    it 'page should contain remove button' do
      visit recipes_path
      expect(page).to have_content('Remove')
    end

    it 'redirect to recipe show page' do
      visit recipes_path
      click_on 'Egg Fry'
      expect(current_path).to match(recipe_specific_path(@recipe.id))
    end

    it 'show recipe details' do
      visit recipe_specific_path(@recipe.id)
      expect(page).to have_content(@recipe.name)
    end

    it 'contain button to add ingredient' do
      visit recipe_specific_path(@user.id, @recipe.id)
      expect(page).to have_content('Add Ingredient')
    end

    it 'contain button to generate shop list' do
      visit recipe_specific_path(@user.id, @recipe.id)
      expect(page).to have_content('Generate Shopping List')
    end
  end
end
