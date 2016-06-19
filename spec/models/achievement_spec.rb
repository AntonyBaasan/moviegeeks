require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'validations' do

    it { should validate_presence_of(:title) }
    # it 'requires title' do
    #   achievement = Achievement.new(title: '')
    #   achievement.valid?
    #
    #   # expect(achievement.valid?).to be_falsy
    #   # expect(achievement.errors[:title]).to include("can't be blank")
    #   expect(achievement.errors[:title]).not_to be_empty
    # end

    it { should validate_uniqueness_of(:title).scoped_to(:user_id).with_message("can't have two achievements with same title") }
    # it 'requires title to be unique for one user' do
    #   user = FactoryGirl.create(:user)
    #   first_achievement = FactoryGirl.create(:public_achievement, title: "Title", user: user)
    #   second_achievement = Achievement.create(title: "Title", user: user) # Can't user FactoryGirl second time, it will fire uniqueness error before
    #   expect(second_achievement.valid?).to be_falsy
    # end
    # it 'allows different users to have achievements with identical titles' do
    #   user1 = FactoryGirl.create(:user)
    #   user2 = FactoryGirl.create(:user)
    #   first_achievement = FactoryGirl.create(:public_achievement, title: "Title", user: user1)
    #   second_achievement = Achievement.create(title: "Title", user: user2) # Can't user FactoryGirl second time, it will fire uniqueness error before
    #   expect(second_achievement.valid?).to be_truthy
    # end


    it { should validate_presence_of(:user) }
    # it 'belongs to user' do
    #   achievement = Achievement.create(title: "Title", user: nil)
    #   expect(achievement.valid?).to be_falsy
    # end

    it { should belong_to(:user) }
    # it 'has belongs_to user association' do
    #   # 1st approach
    #   # user = FactoryGirl.create(:user)
    #   # achievement = FactoryGirl.create(:public_achievement, title: "Title", user: user)
    #   # expect(achievement.user).to be(user)
    #
    #   # 2nd approach
    #   user = Achievement.reflect_on_association(:user)
    #   expect(user.macro).to eq(:belongs_to)
    #
    # end
  end


end
