require 'rails_helper'

# RSpec.describe "achievements/new.html.erb", type: :view do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

require_relative '../../support/new_achievement_form'

feature 'Create new achievement' do

  # page object pattern
  let(:new_achievement_form) { NewAchievementForm.new }

  scenario 'create new achievement with valid data' do

    new_achievement_form.visit_page.fill_in_with(
        title: 'Read a book'
    ).submit

    expect(page).to have_content('Achievement has been created')
    expect(Achievement.last.title).to eq('Read a book')

  end

  scenario 'create new achievement with valid data' do
    new_achievement_form.visit_page.submit
    expect(page).to have_content('can\'t be blank')
  end

end
