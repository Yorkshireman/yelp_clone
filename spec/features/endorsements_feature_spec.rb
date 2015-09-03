require 'rails_helper'

feature 'endorsing reviews' do
  before do
    sign_up_user
    click_link 'Add a restaurant'
    fill_in 'Name', with: "KFC"
    click_button 'Create Restaurant'
    leave_review('It was an abomination', '3')
  end

  scenario 'a user can endorse a review, which increments the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 endorsement')
  end

  context 'when a user has endorsed a review' do
    before do
      sign_out
      sign_up_user2
      @restaurant = Restaurant.last
      @review = @restaurant.reviews.last
      @review.endorsements.create
    end

    scenario 'endorsement is displayed on restaurants page' do
      visit '/restaurants'
      expect(page).to have_content "1 endorsement"
    end
  end

private

def sign_up_user
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def sign_up_user2
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test2@example.com')
  fill_in('Password', with: 'testtest2')
  fill_in('Password confirmation', with: 'testtest2')
  click_button('Sign up')
end

def sign_out
  visit('/')
  click_link 'Sign out'
end

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end

end