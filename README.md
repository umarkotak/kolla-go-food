# README

##Ruby on Rails, introduction##

###Reuirements :###
1. RoR Framework   -> `< gem install rails >`
2. ExecJS file     -> `< gem install execjs >`
3. The Ruby Racer  -> `< gem install therubyracer >`

###Rails config :###
1. gemfile, uncomment on line 20, to use therubyracer
2. type `< bundle >` on terminal

###Rails basic command :###
1. rails new 'file_name' -> generate new apps with rails sekeletal
2. rails generate -> use to generate sekeletor each file
3. rails generate controller Home hello -> will generate Home controller with hello action and view
4. rails g model user -> will generate User model

5. rails server -p 3000 -> will start the apps on port 3000
6. ctrl + c -> to strop current service

7. rails c -> to open rails command line
8. rails db:create -> to create db from current model
9. rails db:migrate -> to generate db that described in db/migrate/'db_name.rb'
10. rails db:rollback -> to move one step back after certain action

11. exit -> to exit rails command line

###Rails Notes :###
1. <% %>  -> to make un printed code at html page (view)
2. <%= %> -> to make printed code at html page (view)

3. User.connection -> to make connection with User db
4. User.find(1) -> will return the first data at User db
5. User.where(username: 'umar') -> will return data that have value 'umar'
6. User.create (username: 'umarkotak', full_name: 'm umar') -> to inser data into database