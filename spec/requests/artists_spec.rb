require 'rails_helper'

RSpec.describe 'Artist', type: :request do
  # initialize test data
  # let!(:artists) { create_list(:artist, 10) }
  # let(:artist_id) { artists.first.id }

  # Test suite for GET /artists
  describe 'GET /artists' do
    context 'with authentication' do
      login
      it 'return success status' do
        get '/artists'
        expect(response).to have_http_status(:success)
      end

      it 'get artists page' do
        get '/artists'
        expect(response).to render_template(:index)
      end
    end

    context 'without authentication' do
      it 'return fail status' do
        get '/artists'
        expect(response).to have_http_status(302)
      end
    end
  end

  # TODO: Test suite for POST /artists

  # TODO: Test suite for PATCH /artists

  # TODO: Test suite for DELETE /artists
end
