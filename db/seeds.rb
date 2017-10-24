# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Food.delete_all

Food.create!(
  name: 'Tenderloin Steak',
  description: %{<p>
  Daging terbaik dari setiap sapi
  rasanya enak gurih gurih nyoy
  </p>},
  image_url: 'Image1.jpg',
  price: 9000
)

Food.create!(
  name: 'Mangstab Steak',
  description: %{<p>
  Daging terbaik dari setiap sapi sumatra
  rasanya enak asin asin gitu
  </p>},
  image_url: 'Image2.jpg',
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
  price: 20000
)