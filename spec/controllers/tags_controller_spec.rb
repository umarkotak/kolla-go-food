require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  before :each do
    user = create(:user)
    session[:user_id] = user.id
  end

  describe 'GET #index' do
    it "populates an array of all tags" do 
      tag1 = create(:tag, name: "Dessert")
      tag2 = create(:tag, name: "Main Course")
      get :index
      expect(assigns(:tags)).to match_array([tag1, tag2])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested tag to @tag" do
      tag = create(:tag)
      get :show, params: { id: tag }
      expect(assigns(:tag)).to eq tag
    end

    it "populates a list of all foods in the tag" do
      tag = create(:tag)
      food1 = create(:food, name: 'nasi')
      food2 = create(:food, name: 'uduk')
      food_tag = create(:food_tag, food: food1, tag: tag)
      food_tag = create(:food_tag, food: food2, tag: tag)

      # raise tag.foods.to_json
      expect(tag.foods).to eq([food1, food2])
    end

    it "renders the :show template" do
      tag = create(:tag)
      get :show, params: { id: tag }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new Tag to @tag" do
      get :new
      expect(assigns(:tag)).to be_a_new(Tag)
    end

    it "renders the :new template" do
      get :new
      expect(:response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested tag to @tag" do
      tag = create(:tag)
      get :edit, params: { id: tag }
      expect(assigns(:tag)).to eq tag
    end

    it "renders the :edit template" do
      tag = create(:tag)
      get :edit, params: { id: tag }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new tag in the database" do
        expect{
          post :create, params: { tag: attributes_for(:tag) }
        }.to change(Tag, :count).by(1)
      end

      it "redirects to tags#show" do
        post :create, params: { tag: attributes_for(:tag) }
        expect(response).to redirect_to(tag_path(assigns[:tag]))
      end
    end

    context "with invalid attributes" do
      it "does not save the new tag in the database" do
        expect{
          post :create, params: { tag: attributes_for(:tag, name: nil) }
        }.not_to change(Tag, :count)
      end

      it "re-renders the :new template" do
        post :create, params: { tag: attributes_for(:tag, name: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @tag = create(:tag)
    end

    context "with valid attributes" do
      it "locates the requested @tag" do
        patch :update, params: { id: @tag, tag: attributes_for(:tag) }
        expect(assigns(:tag)).to eq @tag
      end

      it "changes @tag's attributes" do
        patch :update, params: { id: @tag, tag: attributes_for(:tag, name: 'Dessert') }
        @tag.reload
        expect(@tag.name).to eq('Dessert')
      end

      it "redirects to the tag" do
        patch :update, params: { id: @tag, tag: attributes_for(:tag) }
        expect(response).to redirect_to @tag
      end
    end
    
    context "with invalid attributes" do
      it "does not update the tag in the database" do
        patch :update, params: { id: @tag, tag: attributes_for(:tag, name: nil) }
        @tag.reload
        expect(@tag.name).not_to eq(nil)
      end

      it "re-renders the :edit template" do
        patch :update, params: { id: @tag, tag: attributes_for(:tag, name: nil) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @tag = create(:tag)
    end

    context "with associated foods" do
      it "does not delete the tag from the database" do
        food = create(:food)
        food_tag = create(:food_tag, food: food, tag: @tag)
        expect{
          delete :destroy, params: { id: @tag }
        }.not_to change(Tag, :count)
      end
    end

    context "without associated foods" do
      it "deletes the tag from the database" do
        expect{
          delete :destroy, params: { id: @tag }
        }.to change(Tag, :count).by(-1)
      end

      it "redirects to tags#index" do
        delete :destroy, params: { id: @tag }
        expect(response).to redirect_to tags_url
      end
    end
  end
end
