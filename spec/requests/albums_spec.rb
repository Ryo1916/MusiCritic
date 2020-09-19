require 'rails_helper'

RSpec.describe 'Album', type: :request do
  describe 'GET /albums' do
    context 'with authentication' do
      login
      it 'returns success status' do
        get '/albums'
        expect(response).to have_http_status(:success)
      end

      it 'gets albums page' do
        get '/albums'
        expect(response).to render_template(:index)
      end
    end

    context 'without authentication' do
      it 'returns success status' do
        get '/albums'
        expect(response).to have_http_status(:success)
      end
    end
  end
end
