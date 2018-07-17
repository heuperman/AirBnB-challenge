require './app.rb'

feature 'Listings page ' do
  scenario 'A user can view a listings page' do
    visit('/listings')
    click_button('Add listing')
    expect(current_path).to eq '/listings/new'
  end
end
