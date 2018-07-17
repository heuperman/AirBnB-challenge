require './app.rb'

feature 'Listings page ' do
  scenario 'A user can view a listings page' do
    visit('/listings')
    click_button('Add listing')
    expect(current_path).to eq '/listings/new'
  end
end

feature 'New listings page ' do
  scenario 'A user can add a listings page' do
    visit('/listings/new')
    fill_in('name', with: 'Joe')
    fill_in('price', with: '50')
    fill_in('description', with: '3 bedroom flat to rent')
    click_button('Save')
    expect(current_path).to eq '/listings'
  end
end
