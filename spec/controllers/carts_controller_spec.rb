require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Cart. As you add validations to Cart, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CartsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before :each do
    user = create(:user)
    session[:user_id] = user.id
  end

  # describe "GET #index" do
  #   it "returns a success response" do
  #     cart = Cart.create! valid_attributes
  #     get :index, params: {}, session: valid_session
  #     expect(response).to be_success
  #   end
  # end

  # describe "GET #show" do
  #   it "returns a success response" do
  #     cart = Cart.create! valid_attributes
  #     get :show, params: {id: cart.to_param}, session: valid_session
  #     expect(response).to be_success
  #   end
  # end

  # describe "GET #new" do
  #   it "returns a success response" do
  #     get :new, params: {}, session: valid_session
  #     expect(response).to be_success
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns a success response" do
  #     cart = Cart.create! valid_attributes
  #     get :edit, params: {id: cart.to_param}, session: valid_session
  #     expect(response).to be_success
  #   end
  # end

  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new Cart" do
  #       expect {
  #         post :create, params: {cart: valid_attributes}, session: valid_session
  #       }.to change(Cart, :count).by(1)
  #     end

  #     it "redirects to the created cart" do
  #       post :create, params: {cart: valid_attributes}, session: valid_session
  #       expect(response).to redirect_to(Cart.last)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "returns a success response (i.e. to display the 'new' template)" do
  #       post :create, params: {cart: invalid_attributes}, session: valid_session
  #       expect(response).to be_success
  #     end
  #   end
  # end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested cart" do
  #       cart = Cart.create! valid_attributes
  #       put :update, params: {id: cart.to_param, cart: new_attributes}, session: valid_session
  #       cart.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "redirects to the cart" do
  #       cart = Cart.create! valid_attributes
  #       put :update, params: {id: cart.to_param, cart: valid_attributes}, session: valid_session
  #       expect(response).to redirect_to(cart)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "returns a success response (i.e. to display the 'edit' template)" do
  #       cart = Cart.create! valid_attributes
  #       put :update, params: {id: cart.to_param, cart: invalid_attributes}, session: valid_session
  #       expect(response).to be_success
  #     end
  #   end
  # end

  describe "DELETE #destroy" do
    before :each do
      @cart = create(:cart)
      @dummy_session = valid_session.merge(cart_id: @cart.id)
    end

    context 'with valid cart_id' do
      it "destroys the requested cart from database" do
        expect {
          delete :destroy, params: { id: @cart }, session: @dummy_session
        }.to change(Cart, :count).by(-1)
      end

      it "removes the requested cart from user's session" do
        delete :destroy, params: { id: @cart }, session: @dummy_session
        expect(session[:cart_id]).to be(nil)
      end

      it "redirects to the store index" do
        delete :destroy, params: {id: @cart}, session: @dummy_session 
        expect(response).to redirect_to(store_index_path)
      end
    end

    context 'with invalid cart_id' do
      it 'does not destroy requested cart (different with session)' do
        other_cart = create(:cart)
        expect {
          delete :destroy, params: { id: other_cart }, session: @dummy_session
        }.not_to change(Cart, :count)
      end
    end
  end
end