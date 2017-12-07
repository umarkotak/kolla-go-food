require 'rails_helper'

describe Api::V1::FoodsController do

  describe 'GET #index' do
    context 'with params[:letter]' do
      it 'Populates an array of foods starting with the letter' do
        nasi_uduk = create(:food, name: 'Nasi Uduk')
        kerak_telor = create(:food, name: 'Kerak Telors')
        get :index, format: 'json'
        expect(assigns(:foods)).to match_array([nasi_uduk, kerak_telor])
      end
    end

    context 'Without params[:letter]' do
      it 'Populates an array of all foods' do
        nasi_uduk = create(:food, name: 'Nasi Uduk')
        kerak_telor = create(:food, name: 'Kerak Telor')
        get :index, format: 'json'
        expect(assigns(:foods)).to match_array([nasi_uduk, kerak_telor])
      end
    end
  end

  
end