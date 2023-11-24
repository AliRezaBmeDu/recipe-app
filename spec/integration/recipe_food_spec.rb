RSpec.describe 'Recipe Food', type: :feature do
  before(:each) do
    @user = User.create(name: 'tom', email: 'tom@example.com', password: '1234567890',
                        password_confirmation: '1234567890')
    @recipe = Recipe.create(name: 'Egg Fry', preparation_time: 2, cooking_time: 1, description: 'Boil and mashed egg',
                            public: true, user_id: @user.id)
    @food = Food.create(name: 'Egg', measurement_unit: 'units', price: 0.5, quantity: 200, user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 210, food_id: @food.id, recipe_id: @recipe.id)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end
  describe 'Recipe food page' do
    it 'render add ingredient form' do
      visit new_user_recipe_recipe_food_path(@user,@recipe)
      expect(page).to have_text('Food name')
      expect(page).to have_text('Ingredient quantity')
      expect(page).to have_button('Add Ingredient')
    end
  end
end
