# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  username: 'umarkotak',
  password: 'umarkotak'
)

Category.create!(
  name: 'Seafood'
)

Category.create!(
  name: 'Meat'
)

Category.create!(
  name: 'Epic Food'
)

Restaurant.create!(
  name: 'Waroenk Kito',
  address: 'Jalan ruko semanan no. 45'
)

Restaurant.create!(
  name: 'KFC',
  address: 'Jalan air mancur, bogor'
)

Restaurant.create!(
  name: 'Warung Mbok Galak',
  address: 'Jalan daan mogot'
)

Food.create!(
  name: 'Tenderloin Steak',
  description: %{<p>
  Daging terbaik dari setiap sapi
  rasanya enak gurih gurih nyoy
  </p>},
  image_url: 'Image1.jpg',
  category_id: 1,
  restaurant_id: 2,
  price: 9000
)

Food.create!(
  name: 'Mangstab Steak',
  description: %{<p>
  Daging terbaik dari setiap sapi sumatra
  rasanya enak asin asin gitu
  </p>},
  image_url: 'Image2.jpg',
  category_id: 2,
  restaurant_id: 1,
  price: 15000
)

Food.create!(
  name: 'Bulebule Steak',
  description: %{<p>
  Daging sapi dari luar negeri angin
  dibalut dengan bumbu lada hitam
  pedes pedes manis enak
  </p>},
  image_url: 'Image3.jpg',
  category_id: 3,
  restaurant_id: 1,
  price: 20000
)

Buyer.create!(
  name: 'M Umar Ramadhana',
  email: 'umarkotak@yahoo.co.id',
  phone: '085217251690',
  address: 'taman raya citayam blok f1 no 8'
)

Buyer.create!(
  name: 'Mad Dog',
  email: 'madmad@yahoo.co.id',
  phone: '085217251000',
  address: 'puncak gunung everest no 1'
)

Buyer.create!(
  name: 'Ming Xuanchiang',
  email: 'mingmew@yahoo.co.id',
  phone: '085217251001',
  address: 'pertengahan tembok china no 15'
)

Buyer.create!(
  name: 'Luna Freya',
  email: 'lalune99@yahoo.co.id',
  phone: '085217251002',
  address: 'unknown'
)

Buyer.create!(
  name: 'Sylvester Stalone',
  email: 'sylstal@yahoo.co.id',
  phone: '085217251003',
  address: 'Hoollywoow'
)


