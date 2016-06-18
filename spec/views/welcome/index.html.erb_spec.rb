require 'rails_helper'

# RSpec.describe "welcome/index.html.erb", type: :view do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

feature 'home page' do
  scenario 'welcom message' do
    visit('/')
    expect(page).to have_content('Welcome')
  end
end