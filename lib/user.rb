require 'pg'
require 'bcrypt'
class User
  attr_reader :id

  def initialize(id, email, password)
    @id = id
    @email = email
    @password = password
  end

  def self.create(email, password)
    encrypted_password = BCrypt::Password.create(password)
    connection = connect_database
    result = connection.exec("INSERT INTO users (email, password) VALUES" +
    " ('#{email}', '#{encrypted_password}') RETURNING id, email, password;")
    create_new_user(result)
  end

  def self.connect_database
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'airbnb_test')
    else
      PG.connect(dbname: 'airbnb')
    end
  end

  def self.authenticate(email, password)
    connection = connect_database
    result = connection.exec("SELECT * FROM users WHERE email = '#{email}'")
    if result.any?
      encrypted_password = BCrypt::Password.new(result.first['password'])
      if encrypted_password == password
        create_new_user(result)
      end
    end
  end

  def self.create_new_user(result)
    User.new(
      result.first['id'],
      result.first['email'],
      result.first['password']
    )
  end
end
