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

Artist.create!( artist: "The Beatles",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/1/The-Beatles.jpg"))
Artist.create!( artist: "Led Zeppelin",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/2/ledzeppelin1973_gruen_webuseonly.jpg"))
Artist.create!( artist: "Elvis Presley",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/3/elvis-presley.jpg"))
Artist.create!( artist: "Steely Dan",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/4/steely-dan.jpg"))
Artist.create!( artist: "Red Hot Chili Peppers",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/5/rhcp.jpg"))
Artist.create!( artist: "Radiohead",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/6/radiohead.jpg"))
Artist.create!( artist: "Eagles",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/7/eagles.jpg"))
Artist.create!( artist: "Jimi Hendrix",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/8/jimi-hendrix.jpg"))
Artist.create!( artist: "Eric Clapton",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/9/eric-clapton.jpg"))
Artist.create!( artist: "The Clash",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/10/the-clash.jpg"))
Artist.create!( artist: "Sex Pistols",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/11/sex-pistols.jpg"))
Artist.create!( artist: "New Order",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/12/neworder.jpg"))
Artist.create!( artist: "Billy Joel",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/13/BillyJoel.jpg"))
Artist.create!( artist: "John Mayer",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/14/John_Mayer.jpg"))
Artist.create!( artist: "Nirvana",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/15/nirvana.jpg"))
Artist.create!( artist: "Oasis",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/16/oasis.jpg"))
Artist.create!( artist: "Stone Roses",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/17/stone-roses.jpg"))
Artist.create!( artist: "James Blake",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/18/james-blake.jpg"))
Artist.create!( artist: "Squarepusher",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/19/Squarepusher.jpg"))
Artist.create!( artist: "Aphex Twin",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/20/aphex-twin.jpg"))
Artist.create!( artist: "David Bowie",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/21/david-bowie.jpg"))
Artist.create!( artist: "Bob Dylan",
                artist_image: open("#{Rails.root}/public/uploads/artist/artist_image/22/bob-dylan.jpg"))

Album.create!( album_name: "Sgt. Pepper's Lonely Hearts Club Band",
               release: Date.new(1967, 05, 26),
               genre: "Rock",
               description: "Sgt. Pepper's Lonely Hearts Club Band is the eighth studio album by the English rock band the Beatles.
                            Released on 26 May 1967 in the United Kingdom and 2 June 1967 in the United States,
                            it spent 27 weeks at number one on the UK Albums Chart and 15 weeks at number one in the US.
                            It was lauded by critics for its innovations in production, songwriting and graphic design,
                            for bridging a cultural divide between popular music and high art,
                            and for providing a musical representation of its generation and the contemporary counterculture.
                            It won four Grammy Awards in 1968, including Album of the Year, the first rock LP to receive this honour.
                            In August 1966, the Beatles permanently retired from touring and began a three-month holiday.
                            During a return flight to London in November, Paul McCartney had an idea for a song involving an Edwardian military band that formed the impetus of the Sgt. Pepper concept.
                            Sessions began on 24 November at EMI's Abbey Road Studios with two compositions inspired by the Beatles' youth,
                            \"Strawberry Fields Forever\" and \"Penny Lane\", but after pressure from EMI,
                            the songs were released as a double A-side single and not included on the album.
                            In February 1967, after recording the title track \"Sgt. Pepper's Lonely Hearts Club Band\",
                            McCartney suggested that the Beatles should release an entire album representing a performance by the fictional Sgt. Pepper band.
                            This alter ego group would give them the freedom to experiment musically.
                            During the recording sessions, the band furthered the technological progression they had made with their 1966 album Revolver.
                            Knowing they would not have to perform the tracks live, they adopted an experimental approach to composition and recording on songs such as
                            \"Lucy in the Sky with Diamonds\", \"Being for the Benefit of Mr. Kite!\" and \"A Day in the Life\".
                            Producer George Martin and engineer Geoff Emerick helped realise the group's ideas by approaching the studio as an instrument,
                            applying orchestral overdubs, sound effects and other methods of tape manipulation.
                            Recording was completed on 21 April 1967. The cover, depicting the Beatles posing in front of a tableau of celebrities and historical figures,
                            was designed by the British pop artists Peter Blake and Jann Haworth.
                            Sgt. Pepper is regarded by musicologists as an early concept album that advanced the use of extended form in popular music
                            while continuing the artistic maturation seen on the Beatles' preceding releases.
                            It is described as one of the first art rock LPs, aiding the development of progressive rock,
                            and is credited with marking the beginning of the album era. An important work of British psychedelia,
                            the album incorporates a range of stylistic influences, including vaudeville, circus, music hall, avant-garde, and Western and Indian classical music.
                            In 2003, the Library of Congress placed Sgt. Pepper in the National Recording Registry as \"culturally, historically, or aesthetically significant\".
                            That year, Rolling Stone ranked it number one in its list of the \"500 Greatest Albums of All Time\".
                            As of 2011, it has sold more than 32 million copies worldwide, making it one of the best-selling albums.
                            Professor Kevin Dettmar, writing in The Oxford Encyclopedia of British Literature,
                            described it as \"the most important and influential rock-and-roll album ever recorded\".",
               album_image: open("#{Rails.root}/public/uploads/album/album_image/3/beatles_sgt.jpg"),
               artist_id: 21 )
