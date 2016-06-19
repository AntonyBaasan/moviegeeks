require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:encouragements).with_foreign_key('user_id') }

end
