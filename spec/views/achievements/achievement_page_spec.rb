require 'rails_helper'

feature 'achievement page' do

  scenario 'achievement public page' do

    achievement = FactoryGirl.create(:achievement, title: 'Just do it');
    visit("/achievements/#{achievement.id}")
    expect(page).to have_content('Just do it')

    # achievements = FactoryGirl.create_list(:achievement, 5)
    # p achievements

  end

  scenario 'achievement description display' do

    achievement = FactoryGirl.create(:achievement, description: 'This *was* hard');
    visit("/achievements/#{achievement.id}")

    # p "page: " + page.body

    # expect(page).to have_content('This <em>was</em> hard')
    expect(page).to have_css('em', text: 'was')

  end

end