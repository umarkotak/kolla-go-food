require 'rails_helper'

describe BuyersController do

  before :each do
    user = create(:user)
    session[:user_id] = user.id
  end
  
  describe 'GET #index' do
    context 'with params[:letter]' do
      it 'Populates an array of buyer starting with the letter' do
        umar = create(:buyer, name: 'Umar')
        udin = create(:buyer, name: 'Udin')
        get :index, params: {letter: 'U'}
        expect(assigns(:buyers)).to match_array([umar, udin])
      end
      it 'Renders the :index template' do
        get :index, params: {letter: 'U'}
        expect(response).to render_template :index
      end
    end

    context 'Without params[:letter]' do
      it 'Populates an array of all buyers' do
        umar = create(:buyer, name: 'Umar')
        udin = create(:buyer, name: 'Udin')
        get :index
        expect(assigns(:buyers)).to match_array([umar, udin])
      end
      it 'Renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it 'Assigns the requested buyer to @buyer' do
      buyer = create(:buyer)
      get :show, params: {id: buyer}
      expect(assigns(:buyer)).to eq buyer 
    end

    it 'Renders the :show template' do
      buyer = create(:buyer)
      get :show, params: {id: buyer}
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'Assigns a new buyer to @buyer' do
      get :new
      expect(assigns(:buyer)).to be_a_new(Buyer)
    end
    it 'Renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'Assigns the requested buyer to @buyer' do
      buyer = create(:buyer)
      get :edit, params: {id: buyer}
      expect(assigns(:buyer)).to eq buyer 
    end

    it 'Renders the :edit template' do
      buyer = create(:buyer)
      get :edit, params: {id: buyer}
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'With valid attributes' do
      it 'Saves the new buyer in the database' do
        expect{
          post :create, params: { buyer: attributes_for(:buyer) }
        }.to change(Buyer, :count).by(1)
      end

      it 'Redirects to buyershow' do
        post :create, params: { buyer: attributes_for(:buyer) }
        expect(response).to redirect_to(buyer_path(assigns[:buyer]))
      end
    end

    context 'With invalid attributes' do
      it 'Does not save the new buyer in the database' do
        expect{
          post :create, params: { buyer: attributes_for(:invalid_buyer) }
        }.not_to change(Buyer, :count)
      end

      it 'Re-renders the :new template' do
        post :create, params: { buyer: attributes_for(:invalid_buyer) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @buyer = create(:buyer)
    end

    context 'With valid attributes' do
      it 'Locates the requested @buyer' do
        patch :update, params: { id: @buyer, buyer: attributes_for(:buyer) }
        expect(assigns(:buyer)).to eq @buyer
      end

      it 'Changes @buyer\'s attributes' do
        patch :update, params: { id: @buyer, buyer: attributes_for(:buyer, name: 'Nasi Uduk') }
        @buyer.reload
        expect(@buyer.name).to eq('Nasi Uduk')
      end

      it 'Redirects to the buyer' do
        patch :update, params: { id: @buyer, buyer: attributes_for(:buyer) }
        expect(response).to redirect_to @buyer
      end
    end

    context 'Without invalid attributes' do
      it 'Does not update the buyer in the database' do
        patch :update, params: { id: @buyer, buyer: attributes_for(:buyer, name: 'Nasi Uduk') }
        @buyer.reload
        expect(@buyer.name).to eq('Nasi Uduk')
      end

      it 'Re-renders the :edit template' do
        patch :update, params: { id: @buyer, buyer: attributes_for(:invalid_buyer) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @buyer = create(:buyer)
    end

    it 'Deletes the buyer from the database' do
      expect{
        delete :destroy, params: { id: @buyer }
      }.to change(Buyer, :count).by(-1)
    end

    it 'Redirects to buyers #index' do
      delete :destroy, params: { id: @buyer }
      expect(response).to redirect_to buyers_path
    end
  end

end