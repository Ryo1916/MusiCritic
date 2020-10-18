# frozen_string_literal: true

module Constants
  # base
  APP_NAME = 'MusiCritic'
  DEFAULT_IMG_URL = 'https://img.pngio.com/my-my-png-album-covers-500_500.png'

  # validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # limitations
  ARTISTS_FOR_ARTISTS_INDEX_PAGE = 24
  ALBUMS_FOR_TOP_PAGE = 12
  ALBUMS_FOR_INSTRUCTIONS = 12
  REVIEWS_FOR_ALBUMS_SHOW_PAGE = 15
  REVIEWS_FOR_USRES_SHOW_PAGE = 15
  TOP_RATING_ALBUMS = 24
  NEW_RELEASE_ALBUMS = 24

  # Spotify API
  SPOTIFY_MAX_LIMIT = 50
end
