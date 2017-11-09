require 'rails_helper'

RSpec.describe VouchersController, type: :controller do

  before :each do
    user = create(:user)
    session[:user_id] = user.id
  end
  
  describe 'GET #index' do
    it 'Populates an array of all vouchers' do
      percentx = create(:voucher, kode: 'percentx')
      rupiahx = create(:voucher, kode: 'rupiahx')
      get :index
      expect(assigns(:vouchers)).to match_array([percentx, rupiahx])
    end
    it 'Renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'Assigns the requested voucher to @voucher' do
      voucher = create(:voucher)
      get :show, params: {id: voucher}
      expect(assigns(:voucher)).to eq voucher 
    end

    it 'Renders the :show template' do
      voucher = create(:voucher)
      get :show, params: {id: voucher}
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'Assigns a new voucher to @voucher' do
      get :new
      expect(assigns(:voucher)).to be_a_new(Voucher)
    end
    it 'Renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'Assigns the requested voucher to @voucher' do
      voucher = create(:voucher)
      get :edit, params: {id: voucher}
      expect(assigns(:voucher)).to eq voucher 
    end

    it 'Renders the :edit template' do
      voucher = create(:voucher)
      get :edit, params: {id: voucher}
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before(:each) do
      @category = create(:category, name: 'a')
    end

    context 'With valid attributes' do
      it 'Saves the new voucher in the database' do
        expect{
          post :create, params: { voucher: attributes_for(:voucher) }
        }.to change(Voucher, :count).by(1)
      end

      it 'Redirects to vouchershow' do
        post :create, params: { voucher: attributes_for(:voucher) }
        # raise assigns[:voucher].errors.to_json
        # raise @category.name
        expect(response).to redirect_to(voucher_path(assigns[:voucher]))
      end
    end

    context 'With invalid attributes' do
      it 'Does not save the new voucher in the database' do
        expect{
          post :create, params: { voucher: attributes_for(:invalid_voucher) }
        }.not_to change(Voucher, :count)
      end

      it 'Re-renders the :new template' do
        post :create, params: { voucher: attributes_for(:invalid_voucher) }
        expect(response).to render_template :new
      end
    end
  end

   describe 'PATCH #update' do
    before :each do
      @voucher = create(:voucher)
    end

    context 'With valid attributes' do
      it 'Locates the requested @voucher' do
        patch :update, params: { id: @voucher, voucher: attributes_for(:voucher) }
        expect(assigns(:voucher)).to eq @voucher
      end

      it 'Changes @voucher\'s attributes' do
        patch :update, params: { id: @voucher, voucher: attributes_for(:voucher, kode: 'RUPIAHX') }
        @voucher.reload
        expect(@voucher.kode).to eq('RUPIAHX')
      end

      it 'Redirects to the voucher' do
        patch :update, params: { id: @voucher, voucher: attributes_for(:voucher) }
        expect(response).to redirect_to @voucher
      end
    end

    context 'Without invalid attributes' do
      it 'Does not update the voucher in the database' do
        patch :update, params: { id: @voucher, voucher: attributes_for(:voucher, kode: 'PERCENTX') }
        @voucher.reload
        expect(@voucher.kode).to eq('PERCENTX')
      end

      it 'Re-renders the :edit template' do
        patch :update, params: { id: @voucher, voucher: attributes_for(:invalid_voucher) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @voucher = create(:voucher)
    end

    it 'Deletes the voucher from the database' do
      expect{
        delete :destroy, params: { id: @voucher }
      }.to change(Voucher, :count).by(-1)
    end

    it 'Redirects to vouchers #index' do
      delete :destroy, params: { id: @voucher }
      expect(response).to redirect_to vouchers_path
    end
  end

end
