require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it {is_expected.to have_many :reviews}

  it "when a restaurant is deleted, its reviews are deleted too" do
    @restaurant = Restaurant.create(name: "random")
    @restaurant.reviews.create(thoughts: "blah blah", rating: 4)
    expect { @restaurant.destroy }.to change {Review.count}.by(-1)
  end
end
