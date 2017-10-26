require 'rails_helper'

describe FoodsController do
  describe 'GET #index' do
    context 'with params[:letter]' do
      it 'Populates an array of foods starting with the letter' do
        nasi_uduk = create(:food, name: 'Nasi Uduk')
        kerak_telor = create(:food, name: 'Kerak Telor')
        get :index, params: {letter: 'N'}
        expect(assigns(:foods)).to match_array([nasi_uduk])
      end
      it 'Renders the :index template' do
        get :index, params: {letter: 'N'}
        expect(response).to render_template :index
      end
    end

    context 'Without params[:letter]' do
      it 'Populates an array of all foods' do
        nasi_uduk = create(:food, name: 'Nasi Uduk')
        kerak_telor = create(:food, name: 'Kerak Telor')
        get :index
        expect(assigns(:foods)).to match_array([nasi_uduk, kerak_telor])
      end
      it 'Renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it 'Assigns the requested food to @food' do
      food = create(:food)
      get :show, params: {id: food}
      expect(assigns(:food)).to eq food 
    end

    it 'Renders the :show template' do
      food = create(:food)
      get :show, params: {id: food}
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'Assigns a new food to @food'
    it 'Renders the :new template'
  end

  describe 'GET #edit' do
    it 'Assigns the requested food to @food'
    it 'Renders the :edit template'
  end

  describe 'POST #create' do
    context 'With valid attributes' do
      it 'Saves the new food in the database'
      it 'Redirects to foodshow'
    end

    context 'With invalid attributes' do
      it 'Does not save the new food in the database'
      it 'Re-renders the :new template'
    end
  end

  describe 'PATCH #update' do
    context 'With valid attributes' do
      it 'Locates the requested @food'
      it 'Changes @food\'s attributes'
      it 'Redirects to the food'
    end

    context 'Without invalid attributes' do
      it 'Does not update the food in the database'
      it 'Re-renders the :edit template'
    end
  end

  describe 'DELETE #destroy' do
    it 'Deletes the food from the database'
    it 'Redirects to foods #index'
  end
end