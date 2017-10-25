require 'rails_helper'

describe FoodsController do
  describe 'GET #index' do
    context 'with params[:letter]' do
      it 'Populates an array of foods starting with the letter'
      it 'Renders the :index template'
    end

    context 'Without params[:letter]' do
      it 'Populates an array of all foods'
      it 'Renders the :index template'
    end
  end

  describe 'GET #show' do
    it 'Assigns the requested food to @food'
    it 'Renders the :show template'
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

  desribe 'DELETE #estroy' do
    it 'Deletes the food from the database'
    it 'Redirects to foods #index'
  end
end