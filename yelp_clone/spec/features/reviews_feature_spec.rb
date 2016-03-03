require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form'do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "review[comment]", with: "so so"
    select '3', from: "review[rating]"
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    click_link 'KFC'
    expect(page).to have_content('so so')
  end

end

feature 'reviews and restaurants'do
  before do
    restaurant = Restaurant.create name: 'KFC'
    Review.create comment:'lovely', rating: 4, restaurant_id: restaurant.id
  end
  scenario 'when restaurant is deleted review is also deleted'do
  visit ('/restaurants')
  click_link 'Delete KFC'
  expect(Review.all.length).to eq 0
  end
end
