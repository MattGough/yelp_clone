require 'rails_helper'

feature 'restaurants' do
	context 'no restaurants have been added' do
		scenario ' should display a prompt to add a restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurants yet'
			expect(page).to have_link 'Add a restaurant'
		end
	end
	context 'creating restaurants'do
		scenario 'prompts user to fill out a form, then displays the new restaurant'do
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq '/restaurants'
		end
	end
	context 'restaurants have been added'do
		before do
			Restaurant.create(name: 'KFC')
		end
		scenario 'display restaurants'do
			visit '/restaurants'
			expect(page).to have_content('KFC')
			expect(page).not_to have_content('No restaurants yet')
		end
    scenario 'Restaurants cannot be added twice' do
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
			expect(Restaurant.all.count).to be 1
			expect(page).to have_content "The restaurant already exists"
		end
		scenario 'restaurants name has to be minimum 3 characters' do
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in "Name", with: 'KF'
			expect(page).to have_content 'Name has to be minimum 3 characters'
		end
	context 'viewing restaurants'do

	let!(:mac){Restaurant.create(name:'mac')}
		scenario 'lets a user view a restaurant'do
			visit '/restaurants'
			click_link 'mac'
			expect(page).to have_content 'mac'
			expect(current_path).to eq "/restaurants/#{mac.id}"
		end
	end
	context 'editing restaurants' do

		scenario 'let a user edit a restaurant' do
			visit '/restaurants'
			click_link 'Edit KFC'
			fill_in 'Name', with: 'Kentucky Fried Chicken'
			click_button 'Update Restaurant'
			expect(page).to have_content 'Kentucky Fried Chicken'
			expect(current_path).to eq '/restaurants'
		end
	end

	context 'deleting restaurants' do

	  scenario 'removes a restaurant from the list' do
		  visit '/restaurants'
			click_link "Delete KFC"
			expect(page).not_to have_content 'KFC'
			expect(page).to have_content "Restaurant deleted successfully"
  	end
	end
end

end
