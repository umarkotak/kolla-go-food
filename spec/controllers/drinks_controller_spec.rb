require 'rails_helper'

RSpec.describe DrinksController, type: :controller do

  before :each do
    user = create(:user)
    session[:user_id] = user.id
  end
  
  describe 'GET #index' do
    context 'with params[:letter]' do
      it 'Populates an array of drinks starting with the letter' do
        nasi_uduk = create(:drink, name: 'Nasi Uduk')
        kerak_telor = create(:drink, name: 'Kerak Telor')
        get :index, params: {letter: 'N'}
        expect(assigns(:drinks)).to match_array([nasi_uduk])
      end
      it 'Renders the :index template' do
        get :index, params: {letter: 'N'}
        expect(response).to render_template :index
      end
    end

    context 'Without params[:letter]' do
      it 'Populates an array of all drinks' do
        nasi_uduk = create(:drink, name: 'Nasi Uduk')
        kerak_telor = create(:drink, name: 'Kerak Telor')
        get :index
        expect(assigns(:drinks)).to match_array([nasi_uduk, kerak_telor])
      end
      it 'Renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it 'Assigns the requested drink to @drink' do
      drink = create(:drink)
      get :show, params: {id: drink}
      expect(assigns(:drink)).to eq drink 
    end

    it 'Renders the :show template' do
      drink = create(:drink)
      get :show, params: {id: drink}
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'Assigns a new drink to @drink' do
      get :new
      expect(assigns(:drink)).to be_a_new(Drink)
    end
    it 'Renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'Assigns the requested drink to @drink' do
      drink = create(:drink)
      get :edit, params: {id: drink}
      expect(assigns(:drink)).to eq drink 
    end

    it 'Renders the :edit template' do
      drink = create(:drink)
      get :edit, params: {id: drink}
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before(:each) do
      @category = create(:category, name: 'a')
    end

    context 'With valid attributes' do
      it 'Saves the new drink in the database' do
        expect{
          post :create, params: { drink: attributes_for(:drink).merge(category_id: @category.id) }
        }.to change(Drink, :count).by(1)
      end

      it 'Redirects to drinkshow' do
        post :create, params: { drink: attributes_for(:drink).merge(category_id: @category.id) }
        # raise assigns[:drink].errors.to_json
        # raise @category.name
        expect(response).to redirect_to(drink_path(assigns[:drink]))
      end
    end

    context 'With invalid attributes' do
      it 'Does not save the new drink in the database' do
        expect{
          post :create, params: { drink: attributes_for(:invalid_drink) }
        }.not_to change(Drink, :count)
      end

      it 'Re-renders the :new template' do
        post :create, params: { drink: attributes_for(:invalid_drink) }
        expect(response).to render_template :new
      end
    end
  end

   describe 'PATCH #update' do
    before :each do
      @drink = create(:drink)
    end

    context 'With valid attributes' do
      it 'Locates the requested @drink' do
        patch :update, params: { id: @drink, drink: attributes_for(:drink) }
        expect(assigns(:drink)).to eq @drink
      end

      it 'Changes @drink\'s attributes' do
        patch :update, params: { id: @drink, drink: attributes_for(:drink, name: 'Nasi Uduk') }
        @drink.reload
        expect(@drink.name).to eq('Nasi Uduk')
      end

      it 'Redirects to the drink' do
        patch :update, params: { id: @drink, drink: attributes_for(:drink) }
        expect(response).to redirect_to @drink
      end
    end

    context 'Without invalid attributes' do
      it 'Does not update the drink in the database' do
        patch :update, params: { id: @drink, drink: attributes_for(:drink, name: 'Nasi Uduk') }
        @drink.reload
        expect(@drink.name).to eq('Nasi Uduk')
      end

      it 'Re-renders the :edit template' do
        patch :update, params: { id: @drink, drink: attributes_for(:invalid_drink) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @drink = create(:drink)
    end

    it 'Deletes the drink from the database' do
      expect{
        delete :destroy, params: { id: @drink }
      }.to change(Drink, :count).by(-1)
    end

    it 'Redirects to drinks #index' do
      delete :destroy, params: { id: @drink }
      expect(response).to redirect_to drinks_path
    end
  end
end
