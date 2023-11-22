class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def show
    @food = current_user.foods.find(params[:id])
  end

  def new
    @food = current_user.foods.build
  end

  def create
    @food = current_user.foods.build(food_params)

    if @food.save
      redirect_to @food, notice: 'Food was successfully created.'
    else
      render :new
    end
  end
end
