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

  def self.connect_database
    if ENV['RACK_ENV'] == 'test'
      PG.connect(dbname: 'airbnb_test')
    else
      PG.connect(dbname: 'airbnb')
    end
  end


end
