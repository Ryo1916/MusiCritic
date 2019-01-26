require 'rails_helper'

RSpec.describe 'Album', type: :request do
  # Test suite for GET /albums
  describe 'GET /albums' do
    context 'with authentication' do
      login
      it 'return success status' do
        get '/albums'
        expect(response).to have_http_status(:success)
      end

      it 'get albums page' do
        get '/albums'
        expect(response).to render_template(:index)
      end
    end

    context 'without authentication' do
      it 'return fail status' do
        get '/albums'
        expect(response).to have_http_status(302)
      end
    end
  end
end
