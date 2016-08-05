require 'rails_helper'

feature 'Creating a category' do
 let(:user) { FactoryGirl.create(:user, :admin) }
 let!(:category) { FactoryGirl.create(:category, name: 'Health') }

 before do
  login_as(user)
  visit admin_root_path
  click_link 'Manage Categories'
 end

 scenario 'only admins can create categories' do
  expect(page).to have_content 'Health'
 end

 scenario 'creating a category' do
  click_link 'Create a Category'
  fill_in 'Name', with: 'Books'
  fill_in 'Description', with: 'Category books'
  click_button 'Create Category'
  expect(page).to have_content 'Books'
 end

 scenario 'with invalid details' do
  click_link 'Create a Category'
  fill_in 'Name', with: ''
  fill_in 'Description', with: 'dadaada'
  click_button 'Create Category'
  expect(page).to have_content "can't be blank"
 end
end
