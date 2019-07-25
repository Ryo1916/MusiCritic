# == Schema Information
#
# Table name: artists_albums
#
#  id         :bigint(8)        not null, primary key
#  artist_id  :integer
#  album_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ArtistsAlbum, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
