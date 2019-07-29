# frozen_string_literal: true

module Constants
  # base
  APP_NAME = 'Music Review'
  DEFAULT_IMG_URL = 'https://img.pngio.com/my-my-png-album-covers-500_500.png'

  # validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # set ristrict
  ALBUMS_FOR_TOP_PAGE = 12
  REVIEWS_FOR_ALBUMS_SHOW_PAGE = 15
  REVIEWS_FOR_USRES_SHOW_PAGE = 15
  ARTISTS_FOR_ARTISTS_INDEX_PAGE = 24
  ALBUMS_FOR_ALBUMS_INDEX_PAGE = 24
  NEW_RELEASE_ALBUMS = 32

  # Spotify API
  MAXIMUM_RESULT_LIMITATION_OF_SPOTIFY_API = 50
end
