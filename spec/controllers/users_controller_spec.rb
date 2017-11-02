require 'rails_helper'

describe UsersController do
  describe 'GET #index' do
    context 'with params[:letter]' do
      it 'Populates an array of users starting with the letter' do
        user1 = create(:user, username: 'Nasi Uduk')
        user2 = create(:user, username: 'Kerak Telor')
        get :index
        expect(assigns(:users)).to match_array([user1, user2])
      end
      it 'Renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it 'Assigns the requested user to @user' do
      user = create(:user)
      get :show, params: {id: user}
      expect(assigns(:user)).to eq user 
    end

    it 'Renders the :show template' do
      user = create(:user)
      get :show, params: {id: user}
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'Assigns a new user to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'Renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'Assigns the requested user to @user' do
      user = create(:user)
      get :edit, params: {id: user}
      expect(assigns(:user)).to eq user 
    end

    it 'Renders the :edit template' do
      user = create(:user)
      get :edit, params: {id: user}
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'With valid attributes' do
      it 'Saves the new user in the database' do
        expect{
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it 'Redirects to users#index' do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to users_path
      end
    end

    context 'With invalid attributes' do
      it 'Does not save the new user in the database' do
        expect{
          post :create, params: { user: attributes_for(:invalid_user) }
        }.not_to change(User, :count)
      end

      it 'Re-renders the :new template' do
        post :create, params: { user: attributes_for(:invalid_user) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @user = create(:user, password: 'oldpassword', password_confirmation: 'oldpassword')
    end

    context 'With valid attributes' do
      it 'Locates the requested @user' do
        patch :update, params: { id: @user, user: attributes_for(:user) }
        expect(assigns(:user)).to eq @user
      end

      it 'saves new password' do
        patch :update, params: { id: @user, user: attributes_for(:user, password: 'newlongpassword', password_confirmation: 'newlongpassword') }
        @user.reload
        expect(@user.authenticate('newlongpassword')).to eq(@user)
      end

      it 'Redirects to the user#index' do
        patch :update, params: { id: @user, user: attributes_for(:user) }
        expect(response).to redirect_to users_path
      end

      it "disables login with old password" do
         patch :update, params: { id: @user, user: attributes_for(:user, password: 'newlongpassword', password_confirmation: 'newlongpassword') }
         expect(@user.authenticate('oldlongpassword')).to eq(false)
      end
    end

    context 'Without invalid attributes' do
      it 'Does not update the user in the database' do
        patch :update, params: { id: @user, user: attributes_for(:user, password: nil, password_confirmation: nil) }
        @user.reload
        expect(@user.authenticate(nil)).to eq(false)
      end

      it 'Re-renders the :edit template' do
        patch :update, params: { id: @user, user: attributes_for(:invalid_user) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @user = create(:user)
    end

    it 'Deletes the user from the database' do
      expect{
        delete :destroy, params: { id: @user }
      }.to change(User, :count).by(-1)
    end

    it 'Redirects to users #index' do
      delete :destroy, params: { id: @user }
      expect(response).to redirect_to users_path
    end
  end
end