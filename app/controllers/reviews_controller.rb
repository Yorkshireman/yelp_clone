class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])

    if current_user.has_reviewed? @restaurant
      redirect_to restaurants_path
      flash[:notice] = "You have already reviewed that restaurant"
    end

    if @restaurant.reviews.create(review_params)
      redirect_to restaurants_path
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
