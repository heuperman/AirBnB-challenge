require 'pg'

class Listing
  attr_reader :id, :name, :description, :price, :user_id
  def initialize(id, name, description, price, user_id)
    @id = id
    @name = name
    @description = description
    @price = price
    @user_id = user_id
  end

  def self.all
    connection = connect_database
    result = connection.exec('SELECT * FROM listings')
    result.map do |listing|
       create_new_listing(listing)
     end
  end

  def self.create(name, description, price, user_id)
    connection = connect_database
    result = connection.exec(
      'INSERT INTO listings (name, description, price, user_id) ' +
      "VALUES ('#{name}', '#{description}', '#{price}', '#{user_id}')" +
      ' RETURNING id, name, description, price, user_id;'
    ).first
    create_new_listing(result)
  end

  def ==(other)
    @id = other.id
  end

  def self.create_new_listing(result)
    Listing.new(
      result['id'],
      result['name'],
      result['description'],
      result['price'],
      result['user_id']
    )
  end

  # Maybe we can get this result set from the .all class method
  def self.all_open_requests(user_id)
    connection = connect_database
    result = connection.exec("SELECT * FROM listings WHERE requested = true AND user_id = '#{user_id}'")
    result.map do |listing|
      create_new_listing(listing)
    end
  end

  # Maybe we can get this result set from the .all class method
  def self.all_closed_requests(user_id)
    connection = connect_database
    result = connection.exec("SELECT * FROM listings WHERE available != true AND user_id = '#{user_id}'")
    result.map do |listing|
      create_new_listing(listing)
    end
  end

  # this methods manages the request for a booking
  def self.request_booking(id)
    connection = connect_database
    connection.exec("UPDATE listings SET requested = 'true' WHERE id = '#{id}'")
  end

  # this methods manages the booking
  def self.confirm_booking(id)
    connection = connect_database
    connection.exec("UPDATE listings SET available = 'false', requested = 'false' WHERE id = '#{id}'")
  end

  def self.connect_database
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'airbnb_test')
    else
      PG.connect(dbname: 'airbnb')
    end
  end
end
