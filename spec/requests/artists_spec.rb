require 'rails_helper'

RSpec.describe 'Artist', type: :request do
  describe 'GET /artists' do
    context 'with authentication' do
      login
      it 'returns success status' do
        get '/artists'
        expect(response).to have_http_status(:success)
      end

      it 'gets artists page' do
        get '/artists'
        expect(response).to render_template(:index)
      end
    end

    context 'without authentication' do
      it 'returns fail status' do
        get '/artists'
        expect(response).to have_http_status(302)
      end
    end
  end

  # TODO: Test suite for POST /artists

  # TODO: Test suite for PATCH /artists

  # TODO: Test suite for DELETE /artists
end
