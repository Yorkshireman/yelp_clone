require 'rails_helper'

feature "User Features" do

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
    click_link('Sign out')
  end

  context "when not signed in and on the homepage" do
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

  context "when signed in" do
    before :each do
      sign_up_user
    end

    context "and on the homepage" do
      before :each do
        visit ('/')
      end

      it "should see 'sign out' link" do
        expect(page).to have_link('Sign out')
      end

      it "should not see a 'sign in' link or a 'sign up' link" do
        expect(page).not_to have_link('Sign in')
        expect(page).not_to have_link('Sign up')
      end
    end

    context "when a restaurant has previously been created by a different user" do
      before do
        click_link 'Add a restaurant'
        fill_in 'Name', with: "KFC"
        click_button 'Create Restaurant'
        @restaurant = Restaurant.last
        sign_out
        sign_up_user2
      end

      it "cannot see link to edit a restaurant which they haven't created" do
        expect(page).not_to have_content("Edit KFC")
      end

      it "cannot edit a restaurant they haven't created" do
        visit("/restaurants/#{@restaurant.id}/edit")
        fill_in "Name", with: "Kentucky Fried Chicken"
        click_button "Update Restaurant"
        expect(page).not_to have_content "Kentucky Fried Chicken"
        expect(page).to have_content "You cannot edit someone else's restaurant"
      end

      it "cannot see a link to delete someone else's restaurant" do
        expect(page).not_to have_content "Delete KFC"
      end

      xit "can see a link to delete their own restaurant"

      xit "cannot delete a restaurant that they didn't create"

      xit "can delete their own restaurant"
    end
  end
end