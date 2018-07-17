require 'pg'

if ENV['RACK_ENV'] != 'production'
  require 'rspec/core/rake_task'

  Rspec::Core::RakeTask.new :spec

  task default: [:spec]
end

task :test_database_setup do
  p "Cleaning databases"

  connection = PG.connect(dbname: "airbnb_test")
  connection.exec('TRUNCATE listings;')
end

task :setup do
  p "Creating database"

  ['airbnb', 'airbnb_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{database};")

    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE listings (
      id SERIAL PRIMARY KEY,
      name VARCHAR(60),
      description VARCHAR(350),
      price INT4
      );")
  end
end

task :teardown do
  p "Destroying databases...type ‘y’ to confirm that you want to destroy the"\
  " AirBnB databases. This will remove all data in those databases!"

  confirm = STDIN.gets.chomp

  return unless confirm == 'y'

  ['airbnb', 'airbnb_test'].each do |database|
    connection = PG.connect
    connection.exec("DROP DATABASE #{database};")
  end
end
