require 'rails_helper'

RSpec.describe Review, type: :model do
  it{ is_expected.to belong_to :user }
  it{ is_expected.to belong_to :restaurant }

  it "is invalid if the rating is more than 5" do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end

  it "cannot be created without a user" do
    restaurant = Restaurant.create(name: "testrestaurant")
    review = restaurant.reviews.new({"thoughts" => "blah blah", "rating" => 4})
    expect(review).to have(2).error_on(:user)
  end
end