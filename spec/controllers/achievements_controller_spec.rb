require 'rails_helper'

RSpec.describe AchievementsController, type: :controller do

  shared_examples "public access to achievements" do

    describe 'GET #index' do
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'renders :index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns only public achievement to template' do
        public_achievement = FactoryGirl.create(:public_achievement)
        private_achievement = FactoryGirl.create(:private_achievement)

        get :index
        expect(assigns(:achievements)).to match_array([public_achievement])
      end
    end

    describe 'GET #show' do
      let(:achievement) { FactoryGirl.create(:public_achievement) }

      it 'returns http success' do
        get :show, params: {id: achievement.id}
        expect(response).to have_http_status(:success)
      end

      it 'renders :show template' do
        get :show, params: {id: achievement.id}
        expect(response).to render_template(:show)
      end

      it 'assigns requested achievement to @achievement' do
        get :show, params: {id: achievement.id} # could pass as object
        expect(assigns(:achievement)).to eq(achievement)
      end
    end

  end

  describe 'Guest user' do

    it_behaves_like "public access to achievements"

    describe 'GET #new' do
      it 'redirect to login page' do
        get :new
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'POST #create' do
      let(:achievement_hash) { FactoryGirl.attributes_for(:achievement) }

      it 'redirect to login page' do
        post :create, params: {achievement: achievement_hash}
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'PUT #update' do
      let(:achievement_hash) { FactoryGirl.attributes_for(:achievement) }

      it 'redirect to login page' do
        put :update, params: {id: FactoryGirl.create(:public_achievement), achievement: achievement_hash}
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'DELETE #destroy' do
      it 'redirect to login page' do
        delete :destroy, params: {id: FactoryGirl.create(:public_achievement)}
        expect(response).to redirect_to(new_user_session_url)
      end
    end

  end

  describe 'Authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      # Devise helper method.
      sign_in(user)
    end

    it_behaves_like "public access to achievements"

    describe 'GET #new' do
      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end

      it 'renders :new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns new achievement to @achievement' do
        get :new
        expect(assigns(:achievement)).to be_a_new(Achievement)
      end
    end

    describe 'POST #create' do
      context 'valid data' do
        # creates hash of attributes and values
        let(:achievement_hash) { FactoryGirl.attributes_for(:achievement) }

        it 'redirects to achievements#show view' do
          post :create, params: {achievement: achievement_hash}
          expect(response).to redirect_to(achievement_path(assigns(:achievement)))
        end

        it 'creates new achievements in db' do
          expect {
            post :create, params: {achievement: achievement_hash}
          }.to change(Achievement, :count).by(1)
        end
      end

      context 'invalid data' do
        # creates hash of attributes and values
        let(:invalid_achievement_hash) { FactoryGirl.attributes_for(:achievement, title: '') }

        it 'renders #new view' do
          post :create, params: {achievement: invalid_achievement_hash}
          expect(response).to render_template(:new)
        end

        it 'do not add new achievements in db' do
          expect {
            post :create, params: {achievement: invalid_achievement_hash}
          }.to change(Achievement, :count).by(0)
        end
      end

    end

    context "is not the owner of the achievement" do

      describe 'GET #edit' do
        let(:achievement_hash) { FactoryGirl.attributes_for(:achievement) }

        it 'redirect to achievemnts page' do
          put :edit, params: {id: FactoryGirl.create(:public_achievement), achievement: achievement_hash}
          expect(response).to redirect_to(achievements_path)
        end

      end

      describe 'PUT #update' do
        let(:achievement_hash) { FactoryGirl.attributes_for(:achievement) }

        it 'redirect to achievemnts page' do
          put :update, params: {id: FactoryGirl.create(:public_achievement), achievement: achievement_hash}
          expect(response).to redirect_to(achievements_path)
        end
      end

      describe 'DELETE #destroy' do
        it 'redirect to achievemnts page' do
          delete :destroy, params: {id: FactoryGirl.create(:public_achievement)}
          expect(response).to redirect_to(achievements_path)
        end
      end

    end

    context "is the owner of the achievement" do

      let(:achievement) { FactoryGirl.create(:public_achievement, user: user) }

      describe 'GET #edit' do

        it 'returns http success' do
          get :edit, params: {id: achievement.id}
          expect(response).to have_http_status(:success)
        end

        it 'renders :edit template' do
          get :edit, params: {id: achievement.id}
          expect(response).to render_template(:edit)
        end

        it 'assigns passed achievement to @achievement' do
          get :edit, params: {id: achievement.id} # could pass as object
          expect(assigns(:achievement)).to eq(achievement)
        end
      end

      describe 'PUT #update' do

        context 'valid data' do
          let(:valid_data) { FactoryGirl.attributes_for(:achievement, title: 'New Title') }

          it 'redirects to achievements#show' do
            put :update, params: {id: achievement.id, achievement: valid_data}
            expect(response).to redirect_to(achievement)
          end
          it 'updates the achievement in database' do
            put :update, params: {id: achievement.id, achievement: valid_data}
            achievement.reload
            expect(achievement.title).to eq('New Title')
          end
        end

        context 'invalid data' do
          let(:invalid_data) { FactoryGirl.attributes_for(:achievement, title: '') }

          it 'renders #edit template' do
            put :update, params: {id: achievement.id, achievement: invalid_data}
            expect(response).to render_template(:edit)
          end
          it 'do not updates the achievement in database' do
            put :update, params: {id: achievement.id, achievement: invalid_data}
            achievement.reload
            expect(achievement.title).not_to eq('New Title')
          end

        end

      end

      describe 'DELETE #destroy' do

        it 'redirects to achievements#index view' do
          delete :destroy, params: {id: achievement.id}
          expect(response).to redirect_to(achievement_path)
        end

        it 'deletes an achievements from database' do
          delete :destroy, params: {id: achievement.id}

          expect(Achievement.exists?(achievement.id)).to be_falsy
        end

      end

    end

  end

end

