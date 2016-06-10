require 'rails_helper'

feature 'Create new achievement' do

  scenario 'create new achievement with valid data' do

    visit("/")
    click_on("New Achievement") # button or link, alternatively could use ID or Class

    fill_in('Title', with: 'Read a book')
    fill_in('Description', with: 'Excellent read')
    select('Public', from: 'Privacy')
    check('Featured achievement')
    attach_file('Cover Image', "#{Rails.root}/spec/fixtures/cover_image.jpg")
    click_on("Create Achievement")

    expect(page).to have_content('Achievement has been created')
    expect(Achievement.last.title).to eq('Read a book')
  end
end