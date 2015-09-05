require 'rails_helper'

feature 'Review Features' do
  before do
    sign_up_user
    click_link 'Add a restaurant'
    fill_in 'Name', with: "KFC"
    click_button 'Create Restaurant'
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content "Review successfully created"
    expect(page).to have_content('so so')
  end

  scenario 'user cannot see review link if they have already reviewed the restaurant' do
    leave_review
    visit '/restaurants'
    expect(page).not_to have_content 'Review KFC'
  end

  scenario 'displays an average rating for all reviews' do
    leave_2_reviews
    expect(page).to have_content('★★★★☆')
  end

  xit 'users can only endorse once'

  private

  def leave_2_reviews
    leave_review("so so", '3')
    sign_out
    sign_up_user2
    leave_review("Great!", '5')
  end

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

  def leave_review(thoughts="blah blah", rating='4')
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end
end