require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it {is_expected.to have_many :reviews}

  let(:user) { User.create(email: "test@test.com", password: "passwordpass", password_confirmation: "passwordpass") }

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    user.restaurants.create(name: "Moe's Tavern")
    restaurant = user.restaurants.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  it "when a restaurant is deleted, its reviews are deleted too" do
    user.restaurants.create(name: "restaurant")
    restaurant = Restaurant.last
    restaurant.reviews.create(thoughts: "blah blah", rating: 4)
    expect { restaurant.destroy }.to change {Review.count}.by(-1)
  end

  it "cannot be created without a user_id" do
    expect{ Restaurant.create(name: "testrestaurant")}.not_to change{Restaurant.count}
  end
end
