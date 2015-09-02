class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    # The below is bad because logic should be in the model?
    
    # if current_user.id === @restaurant.user_id
    #   @restaurant.update(restaurant_params)
    #   redirect_to restaurants_path
    # else
    #   redirect_to restaurants_path
    #   flash[:notice] = "You cannot edit someone else's restaurant"
    # end
    
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to restaurants_path
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.destroy
      flash[:notice] = "Restaurant deleted successfully"
      redirect_to restaurants_path
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end
