require './app.rb'

feature 'New listings page ' do
  scenario 'A user can add a listing' do
    visit('/listings')
    click_button('Add listing')
    fill_in('name', with: 'Test name of listing')
    fill_in('price', with: '50')
    fill_in('description', with: 'Test description of listing')
    click_button('Save')
    expect(current_path).to eq '/listings'
  end
end
