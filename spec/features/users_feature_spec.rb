require 'rails_helper'

feature "User can sign in and out" do

  def sign_up_user
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      sign_up_user
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link or a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end

  context "when signed in" do
      before do
        @anon_restaurant = Restaurant.create(name: "Anon Restaurant")
        sign_up_user 
      end

    it "cannot see link to edit a restaurant which they haven't created" do
      expect(page).not_to have_content("Edit Anon Restaurant")
    end

    it "cannot visit the link the edit a restaurant they haven't created" do
      visit("/restaurants/#{@anon_restaurant.id}/edit")
      fill_in "Name", with: "Kentucky Fried Chicken"
      click_button "Update Restaurant"
      expect(current_path).to eq "/restaurants/#{@anon_restaurant.id}/edit"
    end
  end
end