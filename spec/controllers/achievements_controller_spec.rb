require 'rails_helper'

RSpec.describe AchievementsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders :new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns new achievement to @achievement" do
      get :new
      expect(assigns(:achievement)).to be_a_new(Achievement)
    end
  end

  describe "GET #show" do
    let(:achievement) { FactoryGirl.create(:public_achievement) }

    it "returns http success" do
      get :show, params: {id: achievement.id}
      expect(response).to have_http_status(:success)
    end

    it "renders :show template" do
      get :show, params: {id: achievement.id}
      expect(response).to render_template(:show)
    end

    it "assigns requested achievement to @achievement" do
      get :show, params: {id: achievement.id} # could pass as object
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  describe "POST #create" do
    context "valid data" do
      # creates hash of attributes and values
      let(:achievement_hash) { FactoryGirl.attributes_for(:achievement) }

      it "redirects to achievements#show view" do
        post :create, params: {achievement: achievement_hash}
        expect(response).to redirect_to(achievement_path(assigns(:achievement)))
      end

      it "creates new achievements in db" do
        expect {
          post :create, params: {achievement: achievement_hash}
        }.to change(Achievement, :count).by(1)
      end
    end

    context "invalid data" do
      # creates hash of attributes and values
      let(:invalid_achievement_hash) { FactoryGirl.attributes_for(:achievement, title: '') }

      it "renders #new view" do
        post :create, params: {achievement: invalid_achievement_hash}
        expect(response).to render_template(:new)
      end

      it "do not add new achievements in db" do
        expect {
          post :create, params: {achievement: invalid_achievement_hash}
        }.to change(Achievement, :count).by(0)
      end
    end

  end

end
