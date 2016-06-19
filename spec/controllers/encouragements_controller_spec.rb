require 'rails_helper'

RSpec.describe EncouragementsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:author) { FactoryGirl.create(:user) }
  let(:achievement) { FactoryGirl.create(:public_achievement, user: author) }

  context 'guest user' do

    it 'is redirected back to achievement page' do
      get :new, params: {achievement_id: achievement.id}
      expect(response).to redirect_to(achievement_path(achievement))
    end

    it 'is assigns flash message' do
      get :new, params: {achievement_id: achievement.id}
      expect(flash[:alert]).to eq('You must be logged in to encourage people')
    end

  end

  context 'authenticated user' do

    before { sign_in(user) }

    it 'renders :new template' do
      get :new, params: {achievement_id: achievement.id}
      expect(response).to render_template(:new)
    end

    it 'assigns new encouragement to template' do
      get :new, params: {achievement_id: achievement.id}
      expect(assigns(:encouragement)).to be_a_new(Encouragement)
    end

  end

  context 'achievement author' do

    before { sign_in(author) }

    it 'is redirected back to achievement page' do
      get :new, params: {achievement_id: achievement.id}
      expect(response).to redirect_to(achievement_path(achievement))
    end

    it 'is assigns flash message' do
      get :new, params: {achievement_id: achievement.id}
      expect(flash[:alert]).to eq('You can\'t encourage yourself')
    end
  end

  context 'user who already left encouragement for this achievement' do

    before {
      sign_in(user)
      FactoryGirl.create(:encouragement, user: user, achievement: achievement)
    }

    it 'is redirected back to achievement page' do
      get :new, params: {achievement_id: achievement.id}
      expect(response).to redirect_to(achievement_path(achievement))
    end

    it 'is assigns flash message' do
      get :new, params: {achievement_id: achievement.id}
      expect(flash[:alert]).to eq('You already encouraged it.')
    end

  end

end
