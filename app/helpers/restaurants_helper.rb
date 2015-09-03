module RestaurantsHelper
  def already_reviewed_by_user? restaurant
    current_user.reviews.any?{|user_review| restaurant.reviews.include? user_review}
  end
end