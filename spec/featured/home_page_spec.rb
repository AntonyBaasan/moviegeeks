require "rails_helper"

feature 'home page' do
  scenario 'welcom message' do
    visit('/')
    expect(page).to have_content('Welcome')
  end
end