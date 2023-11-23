class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def show
    @food = current_user.foods.find(params[:id])
  end

  def new
    @user = current_user
    @food = @user.foods.new
  end

  def create
    @user = current_user
    @food = @user.foods.new(food_params)

    if @food.save
      redirect_to user_food_path(user_food: @user, id: @food), notice: 'Food was successfully created.'
    else
      render :new
      puts 'Error in saving food'
    end
  end

  def edit
    @food = current_user.foods.find(params[:id])
  end

  def update
    @food = current_user.foods.find(params[:id])

    if @food.update(food_params)
      redirect_to user_food_path(@user, @food), notice: 'Food was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.destroy

    redirect_to foods_url, notice: 'Food was successfully destroyed.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
