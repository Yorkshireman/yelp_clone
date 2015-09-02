require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it {is_expected.to have_many :reviews}

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  it "when a restaurant is deleted, its reviews are deleted too" do
    @restaurant = Restaurant.create(name: "random")
    @restaurant.reviews.create(thoughts: "blah blah", rating: 4)
    expect { @restaurant.destroy }.to change {Review.count}.by(-1)
  end

  xit "cannot be created without a user_id"
  # expect{ Restaurant.create(name: "testrestaurant")}.not_to change{Restaurant.count}
end
