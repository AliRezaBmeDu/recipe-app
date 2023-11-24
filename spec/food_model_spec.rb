require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'creation' do
    before :all do
      @user = User.create(name: 'Tom', email: 'tom@example.com')
      @food = Food.create(name: 'Apple', measurement_unit: 'unit', price: 1, quantity: 200, user_id: @user.id)
    end

    it 'has a name' do
      expect(@food.name).to eq('Apple')
    end

    it 'has measurement unite' do
      expect(@food.measurement_unit).to eq('unit')
    end

    it 'has price' do
      expect(@food.price).to eq(1)
    end

    it 'has quantity' do
      expect(@food.quantity).to eq(200)
    end

    it 'belongs to a user' do
      expect(@food.user_id).to eq(@user.id)
    end
  end
end