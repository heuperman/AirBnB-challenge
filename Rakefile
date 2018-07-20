require 'pg'

if ENV['RACK_ENV'] != 'production'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new :spec

  task default: [:spec]
end

task :test_database_setup do
  p "Cleaning databases"

  connection = PG.connect(dbname: "airbnb_test")
  connection.exec('TRUNCATE listings, users;')
end

task :setup do
  p "Creating database"

  ['airbnb', 'airbnb_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{database};")

    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE users (
      id SERIAL PRIMARY KEY,
      name VARCHAR(60),
      email VARCHAR(60),
      password VARCHAR(60)
      );")
    connection.exec("CREATE TABLE listings (
      id SERIAL PRIMARY KEY,
      name VARCHAR(60),
      description VARCHAR(350),
      price INT4,
      available BOOL DEFAULT TRUE,
      requested BOOL DEFAULT FALSE,
      user_id INTEGER REFERENCES users (id)

      );")

  end
end

task :teardown do
  p "Destroying databases...type 'y’ to confirm that you want to destroy the"\
  " AirBnB databases. This will remove all data in those databases!"

  confirm = STDIN.gets.chomp

  return unless confirm == 'y'

  ['airbnb', 'airbnb_test'].each do |database|
    connection = PG.connect
    connection.exec("DROP DATABASE #{database};")
  end
end

task :populate do
  p "Inserting example listings to the production database"
    connection = PG.connect(dbname: "airbnb")

    connection.exec("INSERT INTO users (name, email, password) VALUES('jay', 'jay@test.com', '$2a$10$H8p0vQ0Svu2owoE1BcJm2.RaempPo1zufzuToYXGPWYEf6OpGlZK');")
    connection.exec("INSERT INTO users (name, email, password) VALUES('jeff', 'jeff@test.com', '$2a$10$rPXfvp7swpukq1MlcqhGEevRJjrvBeCquCf.jMr8b6Hu1f6gYG3Li');")
    connection.exec("INSERT INTO users (name, email, password) VALUES('bibi', 'bibi@test.com', '$2a$10$s6tsUlo7JjcOC8g8PEYY8eKO7I9QY5q2p4rK3V4.wPiGoflcfuB5e');")
    connection.exec("INSERT INTO users (name, email, password) VALUES('kees', 'kees@test.com', '$2a$10$ds8r4FcRWZihNYcIagNa7.ZHWbogG1FQ0IShQjXIXGRbcgJSqKG5m');")

    connection.exec("INSERT INTO listings (name, description, price, user_id) VALUES('Hogwarts boys dorm', 'Magical dorm room for rent', 50, 1);")
    connection.exec("INSERT INTO listings (name, description, price, user_id) VALUES('4 Privet Drive', 'A roomy cosy space under staircase', 25, 2);")
    connection.exec("INSERT INTO listings (name, description, price, user_id) VALUES('Azkaban cell', 'No frills room available all year round!', 10, 1);")
    connection.exec("INSERT INTO listings (name, description, price, user_id) VALUES('Gryffindor House', 'A lovely warm space, would suit family of 300', 100, 3);")
    connection.exec("INSERT INTO listings (name, description, price, user_id) VALUES('Slytherin House', 'A welcoming space, would suit ex-murders', 50, 1);")
    connection.exec("INSERT INTO listings (name, description, price, user_id) VALUES('Hufflepuff House', 'A spacious place, great for all types of people', 75, 1);")
    connection.exec("INSERT INTO listings (name, description, price, user_id) VALUES('Ravenclaw House', 'A warm and cozy space, would suit family of 100', 75, 4);")


end

task :truncate do
  p "Truncating the production database"
    connection = PG.connect(dbname: "airbnb")

    connection.exec('TRUNCATE listings, users;')
end
