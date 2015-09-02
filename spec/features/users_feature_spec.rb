require 'rails_helper'

feature "User Features" do
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
      before :each do
        create_restaurant("KFC")
        @restaurant = Restaurant.last
        sign_out
        sign_up_user2
        create_restaurant("Maccys")
        @restaurant2 = Restaurant.last
      end

      context "editing:" do
        it "cannot see a link to edit that restaurant" do
          expect(page).not_to have_content("Edit KFC")
        end

        it "but can see a link to edit their own restaurant" do
          expect(page).to have_content("Edit Maccys")
        end

        it "cannot edit that other user's restaurant" do
          visit("/restaurants/#{@restaurant.id}/edit")
          fill_in "Name", with: "Kentucky Fried Chicken"
          click_button "Update Restaurant"
          expect(page).not_to have_content "Kentucky Fried Chicken"
          expect(page).to have_content "You cannot edit someone else's restaurant"
        end

        it "but can edit their own restaurant" do
          visit("/restaurants/#{@restaurant2.id}/edit")
          fill_in "Name", with: "MacDonalds"
          click_button "Update Restaurant"
          expect(page).to have_content "MacDonalds"
          expect(page).to have_content "Restaurant successfully updated"
        end
      end

      context "deleting:" do
        it "cannot see a link to delete the other user's restaurant" do
          expect(page).not_to have_content "Delete KFC"
        end

        it "but can see a link to delete their own restaurant" do
          expect(page).to have_content "Delete Maccys"
        end

        # How to do this when you can't see a link?
        # it "cannot delete a restaurant that they didn't create" do
        #   click_link 'Delete KFC'
        #   expect(current_path).to eq '/restaurants'
        #   expect(page).not_to have_content "Restaurant successfully deleted"
        #   expect(page).to have_content "KFC"
        # end

        it "can delete their own restaurant" do
          click_link 'Delete Maccys'
          expect(page).to have_content "Restaurant successfully deleted"
          expect(page).not_to have_content "Maccys"
        end
      end
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
    click_link('Sign out')
  end

  def create_restaurant(name)
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
    click_button 'Create Restaurant'
  end
end