class Song < ApplicationRecord
  belongs_to :artist, optional: true
  belongs_to :album, optional: true
end
