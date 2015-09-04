module RestaurantsHelper
  #Need to test this
  def already_reviewed_by_user? restaurant
    return unless user_signed_in?

    current_user.reviews.any?{|user_review| restaurant.reviews.include? user_review}
  end
end