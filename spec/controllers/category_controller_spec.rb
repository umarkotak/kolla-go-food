require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "populates an array of all categories" do
      cat1 = create(:category, name: 'food')
      cat2 = create(:category, name: 'drink')
      get :index
      expect(assigns(:categories)).to match_array([cat1, cat2])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'Assigns the requested category to @category' do
      category = create(:category)
      get :show, params: {id: category}
      expect(assigns(:category)).to eq category 
    end

    it "populates a list of all foods in the category" do
      category = create(:category)
      food1 = create(:food, category: category)
      food2 = create(:food, category: category)

      get :show, params: { id: category }
      expect(assigns(:category).foods).to match_array([food1, food2])
    end

    it 'Renders the :show template' do
      category = create(:category)
      get :show, params: {id: category}
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'Assigns a new category to @category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end

    it 'Renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'Assigns the requested category to @category' do
      category = create(:category)
      get :edit, params: {id: category}
      expect(assigns(:category)).to eq category 
    end

    it 'Renders the :edit template' do
      category = create(:category)
      get :edit, params: {id: category}
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'With valid attributes' do
      it 'Saves the new category in the database' do
        expect{
          post :create, params: { category: attributes_for(:category) }
        }.to change(Category, :count).by(1)
      end

      it 'Redirects to categoryshow' do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to redirect_to(category_path(assigns[:category]))
      end
    end

    context 'With invalid attributes' do
      it 'Does not save the new category in the database' do
        expect{
          post :create, params: { category: attributes_for(:invalid_category) }
        }.not_to change(Category, :count)
      end

      it 'Re-renders the :new template' do
        post :create, params: { category: attributes_for(:invalid_category) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before :each do
      @category = create(:category)
    end

    context 'With valid attributes' do
      it 'Locates the requested @category' do
        patch :update, params: { id: @category, category: attributes_for(:category) }
        expect(assigns(:category)).to eq @category
      end

      it 'Changes @category\'s attributes' do
        patch :update, params: { id: @category, category: attributes_for(:category, name: 'Nasi Uduk') }
        @category.reload
        expect(@category.name).to eq('Nasi Uduk')
      end

      it 'Redirects to the category' do
        patch :update, params: { id: @category, category: attributes_for(:category) }
        expect(response).to redirect_to @category
      end
    end

    context 'Without invalid attributes' do
      it 'Does not update the category in the database' do
        patch :update, params: { id: @category, category: attributes_for(:category, name: 'Nasi Uduk') }
        @category.reload
        expect(@category.name).to eq('Nasi Uduk')
      end

      it 'Re-renders the :edit template' do
        patch :update, params: { id: @category, category: attributes_for(:invalid_category) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @category = create(:category)
    end

    context 'with associated foods' do
      it "does not delete the category from the database" do
        food = create(:food, category:@category)
        expect{
          delete :destroy, params: { id: @category }
        }.not_to change(Category, :count)
      end
    end

    context 'without associated foods' do
      it "deletes the category from the database" do        
        expect{
          delete :destroy, params: { id: @category }
        }.not_to change(Category, :count).by(-1)
      end
    end

    it 'Deletes the category from the database' do
      expect{
        delete :destroy, params: { id: @category }
      }.to change(Category, :count).by(-1)
    end

    it 'Redirects to categorys #index' do
      delete :destroy, params: { id: @category }
      expect(response).to redirect_to categorys_path
    end
  end

end
