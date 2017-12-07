# README

## Ruby on Rails, introduction ##

### Requirements : ###
1. RoR Framework   -> `< gem install rails >`
2. ExecJS file     -> `< gem install execjs >`
3. The Ruby Racer  -> `< gem install therubyracer >`

### Rails config : ###
1. gemfile, uncomment on line 20, to use therubyracer
2. type `< bundle >` on terminal

### Rails basic command : ###
1. rails new 'file_name' -> generate new apps with rails sekeletal
2. rails generate -> use to generate sekeleton each file
3. rails generate controller Home hello -> will generate Home controller with hello action and view
4. rails g model user -> will generate User model
5. git commit -m "7th commit, add model view controller Food"

5. rails server -p 3000 -> will start the apps on port 3000
6. ctrl + c -> to strop current service

7. rails c -> to open rails command line
8. rails db:create -> to create db from current model
9. rails db:migrate -> to generate db that described in db/migrate/'db_name.rb'
10. rails db:rollback -> to move one step back after certain action

11. exit -> to exit rails command line

12. rails g scaffold Buyer email:string name:string phone:string 

### Rails Notes 1 : ###
1. <% %>  -> to make un printed code at html page (view)
2. <%= %> -> to make printed code at html page (view)

3. User.connection -> to make connection with User db
4. User.find(1) -> will return the first data at User db
5. User.where(username: 'umar') -> will return data that have value 'umar'
6. User.create (username: 'umarkotak', full_name: 'm umar') -> to inser data into database
7. database in rails will return as an special object that containing array data. and that array is an array of object that can also converted into hash
8. make sure the naming is right, plural and singular verbs

### Rails Notes 2 : ###
1. rails new dummy -> creating new RoR web app called dummy
2. edit gemfile as necessary to make the apps run
3. rails g controller Home hello
4. rails g model user
5. rails db:create
6. configure the migrate file at db/migrate/user_file.rb
7. to make new action calle 'goodbye'
8. create inside controller home def 'goodbye'
9. create the view file for 'goodbye' in view/home/
10. configure the routes file in config/routes.rb
11. add get 'home/goodbye'

### Rails Notes 3 : ###
selasa 24/10/2017
1. rails generate rspec:install
2. bundle install after add gem in gemfile
3. rails db:seed -> default value for database
4. rails g scaffold Buyer name:string email:string phone:string address:text
5. using branch while developing new features

### Iteration 1 : Simplified GoFood App ###
1. daftar makanan
2. masukin ke cart, liat yang lain,
3. bayar
4. order history
5. balik ke branch exercise, merger master -> exercise
6. model buyer kasih validasi semua field gaboleh kosong
7. email harus uniq, dan dengan format email
8. phone must contain only number max 12 digits

### Iteration 2 : ###
1. rspec --format documentation
2. 

### Iteration 3 : ###
1. rails generate controller Store index
2. rails g scaffold Cart
3. rails db:migrateS
4. rails generate migration CreateLineItem food:references cart:belongs_to

### Iteration 4 : ###
1. Drink sama kaya food
2. Only CRUD
3. Connect dari category

### Iteration 5 : ###
1. buat model : rails generate model Drink
2. buat controller : rails generate controller drinks
3. buat db:migrate
4. buat routes

### Iteration 6 : ###
1. rails generate model User username:string password:digest
2. rails generate mailer Order receiver shipped

### Action Cable ###
1. rails generate channel foods
2. stream from foods
3. @foods = Food.all?
        ActionCable.server.broadcast 'foods', html: render_to_string('store/index', layout: false)
4. setiap ada broadcast akan diterima channel, kemudian channel akan mencari list subscribe dan mengupdate smua yang terdaftar
5. rails g model Order name address:text email payment_type:integer
6. rails generate migration AddOrderIdToLineItem order:references

### Misc ###
1) To UNDO local file changes but NOT REMOVE your last commit, then use

git reset --hard
2) To UNDO local file changes AND REMOVE your last commit, then use

git reset --hard HEAD^
or
git reset --hard HEAD~
3) To KEEP local file changes and REMOVE ONLY your last commit, then use

git reset --soft HEAD^
or
git reset --soft HEAD~
Use git status and git log frequently to observe your current state.

git push -d origin exercise

### Production ###

export port=3002

port=3002 rails s
untuk jalanin di port lain, cek config/puma.rb

kill -9 proc_id

ps aux | grep puma

menyalakan aplikasi di mode daemon
RAILS_ENV=production SECRET_KEY_BASE=abc puma -C config/puma.rb -d

puma -C config/puma.rb

RAILS_ENV=production rails db:migrate

SECRET_KEY_BASE=abc

RAILS_SERVE_STATIC_FILES=true karna belum ada apache ato puma

rails assets:precompile

sudo apt-get install nginx

sudo service nginx start / restart / stop

sudo rm default

sudo ln -s /etc/nginx/sites_available/kolla_go_food /etc/nginx/sites-enabled/kolla_go_food

### ================================== ###

### ASSOCIATION MATERIAL ###

has_many :book, 