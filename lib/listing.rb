require 'pg'

class Listing
  attr_reader :id, :name, :description, :price
  def initialize(id, name, description, price)
    @id = id
    @name = name
    @description = description
    @price = price
  end

  def self.all
    connection = connect_database
    result = connection.exec('SELECT * FROM listings')
    result.map do |listing|
       create_new_listing(listing)
     end
  end

  def self.create(name, description, price)
    connection = connect_database
    result = connection.exec(
      'INSERT INTO listings (name, description, price) ' +
      "VALUES ('#{name}', '#{description}', '#{price}')" +
      ' RETURNING id, name, description, price;'
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
      result['price']
    )
  end

  # Maybe we can get this result set from the .all class method
  def self.all_open_requests
    connection = connect_database
    result = connection.exec('SELECT * FROM listings WHERE requested = true')
    result.map do |listing|

      # do we need a new class method??
       create_new_listing(listing)
     end
  end

  # Maybe we can get this result set from the .all class method
  def self.all_closed_requests
    connection = connect_database
    result = connection.exec('SELECT * FROM listings WHERE available != true')
    result.map do |listing|

      # do we need a new class method??
       create_new_listing(listing)
     end
  end

  # this methods manages the request for a booking
  def self.request_booking(id)
    # puts id
    connection = connect_database
    connection.exec("UPDATE listings SET requested = 'true' WHERE id = '#{id}'")
    # puts "listing request updated"
  end

  # this methods manages the booking
  def self.book_listing(id)
    connection = connect_database
    connection.exec("UPDATE listings SET available = 'false', requested = 'false' WHERE id = '#{id}'")
    # puts "listing booking updated"
  end

  def self.connect_database
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'airbnb_test')
    else
      PG.connect(dbname: 'airbnb')
    end
  end
end
