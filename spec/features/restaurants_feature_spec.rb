require 'rails_helper'

feature 'Restaurant Features' do

  def sign_up_user
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  def create_kfc
    click_link 'Add a restaurant'
    fill_in 'Name', with: "KFC"
    click_button 'Create Restaurant'
  end

  context 'when no restaurants have been added' do
    scenario 'there should be a prompt to add a restaurant on the restaurants page' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
  	before do
      sign_up_user
      create_kfc
  	end

  	scenario 'display restaurants' do
  		visit '/restaurants'
  		expect(page).to have_content("KFC")
  		expect(page).not_to have_content("No restaurants yet")
  	end
  end

  context "creating restaurants" do
    before :each do
     sign_up_user
    end

    scenario "prompts users to fill out a form, then displays the new restaurant" do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: "KFC"
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario "cannot be created without being signed-in" do
      click_link('Sign out')
      visit('/restaurants/new')
      expect(page).to have_content "You need to sign in or sign up before continuing"
    end

    context 'when trying to create an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context "viewing restaurants" do
    before do
      sign_up_user
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: "KFC"
      click_button 'Create Restaurant'
      @restaurant = Restaurant.last
    end

    scenario "lets a user view a restaurant" do
      visit "/restaurants"
      click_link "KFC"
      expect(page).to have_content("KFC")
      expect(current_path).to eq "/restaurants/#{@restaurant.id}"
    end

    context "editing restaurants" do
      scenario "let a user edit a restaurant" do
        visit "/restaurants"
        click_link "Edit KFC"
        fill_in "Name", with: "Kentucky Fried Chicken"
        click_button "Update Restaurant"
        expect(page).to have_content "Kentucky Fried Chicken"
        expect(page).to have_content "Restaurant successfully updated"
        expect(current_path).to eq "/restaurants"
      end
    end

    context "deleting restaurants" do
      scenario 'removes a restaurant when a user clicks a delete link' do
        visit '/restaurants'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant successfully deleted'
      end
    end
  end

end