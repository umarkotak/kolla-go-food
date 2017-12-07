# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create!(
  name: 'admin'
)

Role.create!(
  name: 'customer'
)

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
