require 'rails_helper'

describe OrdersController do

  before :each do
    user = create(:user)
    session[:user_id] = user.id
  end

  it "includes CurrentCart" do
    expect(OrdersController.ancestors.include? CurrentCart).to eq(true)
  end

  describe "GET #index" do
    it "populates an array of all ordes" do
      order1 = create(:order, name:'Buyer 1')
      order2 = create(:order, name:'Buyer 2')
      get :index
      expect(assigns(:orders)).to match_array([order1, order2])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested order to @order" do
      order = create(:order)
      get :show, params: {id: order}
      expect(assigns(:order)).to eq order
    end

    it "renders the :show template" do
      order = create(:order)
      get :show, params: {id: order}
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    context "with non-empty cart" do
      before :each do
        @cart = create(:cart)
        session[:cart_id] = @cart.id
        @line_item = create(:line_item, cart: @cart)
      end

      it " assigns a new Order to @order" do
        get :new
        expect(assigns(:order)).to be_a_new(Order)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "with empty cart" do
      before :each do
        @cart = create(:cart)
        session[:cart_id] = @cart.id        
      end

      it "redirects to the store index page" do
        get :new
        expect(response).to redirect_to(store_index_path)
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested order to @order" do
      order = create(:order)
      get :edit, params: {id: order}
      expect(assigns(:order)).to eq order
    end

    it "renders the :edit template" do
      order = create(:order)
      get :edit, params: { id: order }
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before :each do
        @cart = create(:cart)
        session[:cart_id] = @cart.id
        
      end
      it "saves the new Order in the database" do
        expect{
          post :create, params: { order: attributes_for(:order) }
        }.to change(Order, :count).by(1)
      end

      it "destroy session's cart" do        
        expect{
          post :create, params: { order: attributes_for(:order) }
        }.to change(Cart, :count).by(-1)
      end

      it "removes the cart from session's params" do
        post :create, params: { order: attributes_for(:order) }
        expect(response).to redirect_to store_index_path
      end

      it "redirect to store index page" do
        post :create, params: { order: attributes_for(:order) }
        expect(response).to redirect_to store_index_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new order in the database" do
        expect{
          post :create, params: { order: attributes_for(:invalid_order) }
        }.not_to change(Order, :count)
      end

      it "re render the :new template" do
        post :create, params: { order: attributes_for(:invalid_order) }
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before :each do
      @order = create(:order)
    end

    context "with valid attributes" do
      it "locates the requested @order" do
        patch :update, params:{ id: @order, order: attributes_for(:order) }
        expect(assigns(:order)).to eq @order
      end

      it "changes @order's attributes" do
        post :update, params: { id: @order, order: attributes_for(:order, name: 'umar') }
        @order.reload
        expect(@order.name).to eq('umar')
      end

      it "redirects to the order" do
        post :update, params: { id: @order, order: attributes_for(:order) }
        expect(response).to redirect_to @order
      end
    end

    context "with invalid attributes" do
      it "does not update the iorder in the database" do
        patch :update, params: { id: @order, order: attributes_for(:order, name: 'umar') }
        expect(assigns(:order)).not_to eq('umar')
      end

      it "re renders the :edit template" do
        patch :update, params: { id: @order, order: attributes_for(:invalid_order) }
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @order = create(:order)
    end

    it "deletes the order from the database" do
      expect{
        delete :destroy, params: { id: @order }
        }.to change(Order, :count).by(-1)
    end

    it "redirect to orders#index" do
      delete :destroy, params: { id: @order }
      expect(response).to redirect_to orders_url
    end
  end
end