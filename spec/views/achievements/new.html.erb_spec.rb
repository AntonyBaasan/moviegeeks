require 'rails_helper'
require_relative '../../support/new_achievement_form'
require_relative '../../support/login_form'

feature 'Create new achievement' do

  # page object pattern
  let(:new_achievement_form) { NewAchievementForm.new }
  let(:login_form) { LoginForm.new }
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_form.visit_page.login_as(user)

    # clear ActionMailer
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

  end

  scenario 'create new achievement with valid data' do

    new_achievement_form.visit_page.fill_in_with(
        title: 'Read a book'
    ).submit

    expect(page).to have_content('Achievement has been created')
    expect(Achievement.last.title).to eq('Read a book')

  end

  scenario 'uploads image of the achievement' do

    new_achievement_form.visit_page.fill_in_with(
        title: 'Read a book',
        cover_image: 'cover_image.jpg'

    ).submit

    # 'cover_image_identifier' distributer from Carriwave
    # p 'Achievement.last.cover_image.current_path: ' + Achievement.last.cover_image.current_path
    expect(Achievement.last.cover_image_identifier).to eq('cover_image.jpg')
  end

  scenario 'sends email after achievement create' do

    new_achievement_form.visit_page.fill_in_with(
        title: 'Read a book'
    ).submit

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.last.to).to include(user.email)

  end

  scenario 'create new achievement with valid description' do

    new_achievement_form.visit_page.fill_in_with(
        title: 'Read a book',
        description: 'Description'
    ).submit

    expect(page).to have_content('Achievement has been created')
    expect(Achievement.last.description).to eq('Description')

  end

  scenario 'create new achievement with valid data' do

    new_achievement_form.visit_page.submit
    expect(page).to have_content('can\'t be blank')
  end

end
