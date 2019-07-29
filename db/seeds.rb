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
  external_urls: 'https://open.spotify.com/artist/74Ch11L4833kZ9VfyziR3K',
  spotify_id: ''
)

# FIXME: Use below data after fix save api data logic
# Artist.create!(
#   name: "Steely Dan",
#   image: "https://i.scdn.co/image/9d01e4e9aac39b891d684d3d1a5b3a451d7c72bd",
#   external_urls: "https://open.spotify.com/artist/6P7H3ai06vU1sGvdpBwDmE"
# )
# Artist.create!(
#   name: "Robben Ford",
#   image: "https://i.scdn.co/image/397f33fd3f87e4a4c86f3e11140718d72918b892",
#   external_urls: "https://open.spotify.com/artist/7C1CFA2GWGFc51SrvX5Bvy"
# )
#
# Album.create!(
#   name: "The Inside Story",
#   release_date: "1979-05-01",
#   external_urls: "https://open.spotify.com/album/5mx3ypa6y6xA3ZQKIEI0j7",
#   image: "https://i.scdn.co/image/d67cf92012e97c99fcc831cc0a6ca95ede954200",
#   artist_id: Artist.second.id
# )
# Album.create!(
#   name: "Aja",
#   release_date: "1977-01-01",
#   external_urls: "https://open.spotify.com/album/51XjnQQ9SR8VSEpxPO9vrW",
#   image: "https://i.scdn.co/image/a4fd527c39a4cd754b334496f03f08a98b35e8c6",
#   artist_id: Artist.first.id
# )
