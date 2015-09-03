require 'rails_helper'

RSpec.describe Review, type: :model do
  it{ is_expected.to belong_to :user }
  it{ is_expected.to belong_to :restaurant }

  it "is invalid if the rating is more than 5" do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end

  it "cannot be created without a user_id" do
    expect{ Review.create(thoughts: "testthoughts")}.not_to change{Review.count}
  end
end
