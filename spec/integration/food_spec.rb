require 'rails_helper'

RSpec.describe 'Food', type: :feature do
  before(:each) do
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: '1234567890',
                        password_confirmation: '1234567890')
    @recipe = Recipe.create(name: 'Egg Fry', preparation_time: 2, cooking_time: 3, description: 'Oil and salt',
                            public: true, user_id: @user.id)
    @food = Food.create(name: 'Egg', measurement_unit: 'units', price: 1, quantity: 15, user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 20, food_id: @food.id, recipe_id: @recipe.id)

    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end

  describe 'Test for food page' do
    it 'create new food' do
      visit new_user_food_path(@user)
      fill_in 'Name', with: 'Apple'
      fill_in 'Measurement unit', with: 'unit'
      fill_in 'Price', with: 1
      fill_in 'Quantity', with: 50
      click_button 'Create Food'
      expect(page).to have_content('Apple')
    end

    it 'have food contents' do
      visit foods_path
      expect(page).to have_content(@food.name)
      expect(page).to have_content(@food.measurement_unit)
      expect(page).to have_content(@food.price)
      expect(page).to have_content('Add New Food')
    end

    it 'have a delete button' do
      visit foods_path
      expect(page).to have_content('Delete')
    end
  end
end
