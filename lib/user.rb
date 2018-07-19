require 'pg'
class User
  attr_reader :id

  def initialize(id, email, password)
    @id = id
    @email = email
    @password = password
  end

  def self.create(email, password)
    connection = connect_database
    result = connection.exec("INSERT INTO users (email, password) VALUES" +
    " ('#{email}', '#{password}') RETURNING id, email, password;")
    User.new(
      result.first['id'],
      result.first['email'],
      result.first['password']
    )
  end

  def self.connect_database
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'airbnb_test')
    else
      PG.connect(dbname: 'airbnb')
    end
  end
end
