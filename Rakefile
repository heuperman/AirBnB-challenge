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
      available BOOL,
      requested BOOL,
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

    connection.exec("INSERT INTO users (name, email, password) VALUES('jay', 'jay@test.com', 'jay123');")
    connection.exec("INSERT INTO users (name, email, password) VALUES('jeff', 'jeff@test.com', 'jeff123');")
    connection.exec("INSERT INTO users (name, email, password) VALUES('bibi', 'bibi@test.com', 'bibi123');")
    connection.exec("INSERT INTO users (name, email, password) VALUES('kees', 'kees@test.com', 'kees123');")

    connection.exec("INSERT INTO listings (name, description, price, available, requested, user_id) VALUES('Hogwarts boys dorm', 'Magical dorm room for rent', 50, FALSE, FALSE, 1);")
    connection.exec("INSERT INTO listings (name, description, price, available, requested, user_id) VALUES('4 Privet Drive', 'A roomy cosy space under staircase', 25, FALSE, FALSE, 2);")
    connection.exec("INSERT INTO listings (name, description, price, available, requested, user_id) VALUES('Azkaban cell', 'No frills room available all year round!', 10, FALSE, FALSE, 1);")
    connection.exec("INSERT INTO listings (name, description, price, available, requested, user_id) VALUES('Gryffindor House', 'A lovely warm space, would suit family of 300', 100, FALSE, FALSE, 3);")
    connection.exec("INSERT INTO listings (name, description, price, available, requested, user_id) VALUES('Slytherin House', 'A welcoming space, would suit ex-murders', 50, FALSE, FALSE, 1);")
    connection.exec("INSERT INTO listings (name, description, price, available, requested, user_id) VALUES('Hufflepuff House', 'A spacious place, great for all types of people', 75, FALSE, FALSE, 1);")
    connection.exec("INSERT INTO listings (name, description, price, available, requested, user_id) VALUES('Ravenclaw House', 'A warm and cozy space, would suit family of 100', 75, FALSE, FALSE, 4);")


end

task :truncate do
  p "Truncating the production database"
    connection = PG.connect(dbname: "airbnb")

    connection.exec('TRUNCATE listings, users;')
end
