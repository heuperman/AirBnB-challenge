require 'pg'
class Listing
  attr_reader :id
  def initialize(id, name, description, price)
    @id = id
    @name = name
    @description = description
    @price = price
  end

  def self.create(name, description, price)
    if ENV['RACK_ENV'] == 'test'
      @connection = PG.connect(dbname: 'airbnb_test')
    else
      @connection = PG.connect(dbname: 'airbnb')
    end
    result = @connection.exec(
      "INSERT INTO listings (name, description, price) " +
      "VALUES ('#{name}', '#{description}', '#{price}')" +
      " RETURNING id, name, description, price;"
    ).first
    Listing.new(
      result['id'],
      result['name'],
      result['description'],
      result['price']
    )
  end
end
