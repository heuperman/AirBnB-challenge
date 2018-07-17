require './app.rb'

feature 'New listings page ' do
  scenario 'A user can add a listing' do
    visit('/listings')
    click_button('Add listing')
    fill_in('name', with: 'Joe')
    fill_in('price', with: '50')
    fill_in('description', with: '3 bedroom flat to rent')
    click_button('Save')
    expect(current_path).to eq '/listings'
  end
end
