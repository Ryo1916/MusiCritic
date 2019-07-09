# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!( name:                  "jimbob",
              email:                 "jimbob@test.abc",
              password:              "password",
              password_confirmation: "password",
              sign_in_count:         1 )

Artist.create!(
  name: 'Unknown Artist',
  image: Constants::DEFAULT_IMG_URL,
  external_urls: 'https://open.spotify.com/artist/74Ch11L4833kZ9VfyziR3K'
)
