# db/seeds.rb

require "open-uri"  # Needed if attaching images from a URL

# 1) Destroy existing records in a safe order
  Order.destroy_all
  Product.destroy_all
  User.destroy_all

# 2) Create 20 Users (Devise requires real passwords)
users = User.create!([
  { email: "alice.smith@example.com",    password: "password123" },
  { email: "bob.jones@example.com",      password: "password123" },
  { email: "charlie.miller@example.com", password: "password123" },
  { email: "diana.baker@example.com",    password: "password123" },
  { email: "evan.lee@example.com",       password: "password123" },
  { email: "fiona.roberts@example.com",  password: "password123" },
  { email: "george.king@example.com",    password: "password123" },
  { email: "hannah.davis@example.com",   password: "password123" },
  { email: "ian.young@example.com",      password: "password123" },
  { email: "julia.scott@example.com",    password: "password123" },
  { email: "kevin.adams@example.com",    password: "password123" },
  { email: "lisa.ward@example.com",      password: "password123" },
  { email: "mike.brown@example.com",     password: "password123" },
  { email: "nina.white@example.com",     password: "password123" },
  { email: "oscar.clark@example.com",    password: "password123" },
  { email: "paula.mitchell@example.com", password: "password123" },
  { email: "quentin.green@example.com",  password: "password123" },
  { email: "rachel.hill@example.com",    password: "password123" },
  { email: "sam.patterson@example.com",  password: "password123" },
  { email: "tina.evans@example.com",     password: "password123" }
])

puts "Created #{User.count} users."

# 3) Define 50 Product attributes (13 'vinil', 12 'cd', 13 'fita cassete', 12 'old stuff')
#    We'll store them in an array of hashes, then create them programmatically
product_attributes = [
  # ====== VINIL (13) ======
  { category: "vinil", name: "Pink Floyd - The Wall",         description: "Classic double album from 1979.",                 price: 29.99 },
  { category: "vinil", name: "The Beatles - Abbey Road",      description: "Iconic 1969 album featuring 'Come Together'.",    price: 24.99 },
  { category: "vinil", name: "Rolling Stones - Sticky Fingers",description: "Famous album with the legendary zipper cover.",  price: 21.99 },
  { category: "vinil", name: "Led Zeppelin IV",               description: "Features 'Stairway to Heaven' and other classics.",price: 22.50 },
  { category: "vinil", name: "AC/DC - Back in Black",          description: "One of the best-selling albums of all time.",    price: 19.99 },
  { category: "vinil", name: "Nirvana - Nevermind",            description: "90s grunge album featuring 'Smells Like Teen Spirit'.", price: 18.99 },
  { category: "vinil", name: "Queen - A Night at the Opera",   description: "Includes 'Bohemian Rhapsody'. A rock masterpiece.", price: 25.99 },
  { category: "vinil", name: "Fleetwood Mac - Rumours",        description: "One of the most celebrated albums in pop/rock history.", price: 23.99 },
  { category: "vinil", name: "Eagles - Hotel California",      description: "Landmark 1976 release featuring the classic title track.", price: 20.99 },
  { category: "vinil", name: "Prince - Purple Rain",           description: "Grammy Award-winning soundtrack from 1984.",      price: 22.99 },
  { category: "vinil", name: "Michael Jackson - Off the Wall", description: "1979 disco/funk classic produced by Quincy Jones.", price: 24.50 },
  { category: "vinil", name: "David Bowie - Ziggy Stardust",   description: "Groundbreaking glam-rock album from 1972.",       price: 26.99 },
  { category: "vinil", name: "The Doors - The Doors",          description: "Debut album featuring 'Light My Fire'.",          price: 17.99 },

  # ====== CDs (12) ======
  { category: "cd", name: "Michael Jackson - Thriller",        description: "Best-selling album of all time, featuring 'Beat It'.", price: 14.99 },
  { category: "cd", name: "Madonna - Like a Virgin",           description: "Iconic pop album from the 80s, produced by Nile Rodgers.", price: 12.99 },
  { category: "cd", name: "Bruce Springsteen - Born in the USA",description: "1984 smash hit album from 'The Boss'.",           price: 13.99 },
  { category: "cd", name: "U2 - The Joshua Tree",              description: "Grammy-winning album including 'With or Without You'.", price: 13.49 },
  { category: "cd", name: "Mariah Carey - Daydream",           description: "Pop/R&B album featuring 'Fantasy' and 'One Sweet Day'.", price: 11.99 },
  { category: "cd", name: "Whitney Houston - The Bodyguard (OST)", description: "Best-selling movie soundtrack, includes 'I Will Always Love You'.", price: 15.99 },
  { category: "cd", name: "Nirvana - In Utero",                description: "Raw 1993 follow-up album to Nevermind.",           price: 12.49 },
  { category: "cd", name: "Coldplay - Parachutes",             description: "Debut album featuring 'Yellow'.",                  price: 10.99 },
  { category: "cd", name: "Linkin Park - Hybrid Theory",       description: "Groundbreaking nu-metal album from 2000.",         price: 13.99 },
  { category: "cd", name: "Alanis Morissette - Jagged Little Pill", description: "Massive 90s pop-rock success including 'Ironic'.", price: 9.99 },
  { category: "cd", name: "Adele - 21",                        description: "Record-breaking album featuring 'Rolling in the Deep'.", price: 14.50 },
  { category: "cd", name: "Beyoncé - Lemonade",                description: "Critically acclaimed visual album from 2016.",     price: 15.49 },

  # ====== FITA CASSETE (13) ======
  { category: "fita cassete", name: "Elvis Presley (Cassette)",description: "1956 rock and roll classic, reissued on cassette.", price: 7.99 },
  { category: "fita cassete", name: "The Beach Boys - Pet Sounds (Cassette)", description: "Critically acclaimed 1966 album, cassette edition.", price: 8.99 },
  { category: "fita cassete", name: "Stevie Wonder - Songs in the Key of Life (Cassette)", description: "1976 soul/funk classic on cassette.", price: 9.49 },
  { category: "fita cassete", name: "Bob Dylan - Highway 61 Revisited (Cassette)", description: "Seminal 1965 album, featuring 'Like a Rolling Stone'.", price: 8.49 },
  { category: "fita cassete", name: "The Clash - London Calling (Cassette)", description: "Revolutionary 1979 punk rock album, cassette edition.", price: 9.99 },
  { category: "fita cassete", name: "Guns N' Roses - Appetite for Destruction (Cassette)", description: "1987 hard rock debut.", price: 8.99 },
  { category: "fita cassete", name: "Metallica - Master of Puppets (Cassette)", description: "Groundbreaking thrash metal from 1986.", price: 9.99 },
  { category: "fita cassete", name: "Soundgarden - Superunknown (Cassette)", description: "1994 grunge/alternative rock essential.", price: 8.49 },
  { category: "fita cassete", name: "Pearl Jam - Ten (Cassette)", description: "Early 90s Seattle grunge classic on cassette.", price: 7.49 },
  { category: "fita cassete", name: "Red Hot Chili Peppers - Blood Sugar Sex Magik (Cassette)", description: "1991 funk-rock masterpiece.", price: 8.99 },
  { category: "fita cassete", name: "Depeche Mode - Violator (Cassette)", description: "1990 synth-pop classic.", price: 9.49 },
  { category: "fita cassete", name: "Janet Jackson - Rhythm Nation 1814 (Cassette)", description: "1989 pop/R&B album with social themes.", price: 8.49 },
  { category: "fita cassete", name: "R.E.M. - Automatic for the People (Cassette)", description: "Critically acclaimed 1992 release.", price: 7.99 },

  # ====== OLD STUFF (12) ======
  { category: "old stuff", name: "Vintage Gramophone (1900s)", description: "Antique disc-playing phonograph with a classic horn.", price: 79.99 },
  { category: "old stuff", name: "Antique Phonograph Cylinder",description: "Rare early recording medium from the late 1800s.",    price: 49.99 },
  { category: "old stuff", name: "Retro 8-Track Tape Player",  description: "Classic 1970s portable music player.",               price: 34.99 },
  { category: "old stuff", name: "Old RCA Victor Record Player",description: "Mid-century record player in working condition.",   price: 59.99 },
  { category: "old stuff", name: "Vintage Transistor Radio",    description: "Pocket radio from the 1960s, collectible shape.",    price: 19.99 },
  { category: "old stuff", name: "Original Sony Walkman (TPS-L2)", description: "First-generation cassette Walkman from 1979.",    price: 89.99 },
  { category: "old stuff", name: "Antique Victrola Cabinet",    description: "Floor-standing Victrola from early 1900s.",         price: 120.00 },
  { category: "old stuff", name: "Polaroid Land Camera (1970s)",description: "Instant camera that develops photos on the spot.",   price: 35.99 },
  { category: "old stuff", name: "Vintage Car 8-Track Tapes",   description: "Assorted 1970s classics for in-car 8-track players.",price: 15.99 },
  { category: "old stuff", name: "Classic Sony Boombox (1980s)",description: "Loud, portable stereo with cassette and AM/FM.",     price: 44.99 },
  { category: "old stuff", name: "Reel-to-Reel Tape Recorder",  description: "Studio-grade reel-to-reel recorder from 1970s.",     price: 99.99 },
  { category: "old stuff", name: "Apple Macintosh Classic (1984)",description: "Retro personal computer for collectors.",           price: 150.00 }
]

# Actually create the 50 Product records, assigning user: users[i % users.size]
products = product_attributes.each_with_index.map do |attrs, i|
  Product.create!(
    category:    attrs[:category],
    name:        attrs[:name],
    description: attrs[:description],
    price:       attrs[:price],
    user:        users[i % users.size]  # ensures we pick a valid user from the array
  )
end

puts "Created #{Product.count} products."

# 4) (Optional) Attach a random placeholder image to each product
#    Make sure your Product model has "has_one_attached :image"
products.each_with_index do |product, i|
  # We'll pick a stable random placeholder from picsum.photos
  image_url = "https://picsum.photos/seed/PRODUCT_#{i}/600/600"

  downloaded_image = URI.open(image_url)  # downloads image bytes
  product.photo.attach(
    io:           downloaded_image,
    filename:     "product_#{i}.jpg",
    content_type: "image/jpeg"
  )

  puts "Attached image to product: #{product.name}"
end

puts "Seeding complete!"
