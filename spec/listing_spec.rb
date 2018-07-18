require 'listing'

describe Listing do
  describe '.create' do
    it 'creates a new listing' do
      listing = Listing.create('house', 'nice garden', 100)
      expect(listing.id).not_to be_nil
    end
  end

  describe '.all' do
    it 'returns all listings' do
      listings = [
        Listing.create('house1', 'nice garden', 100),
        Listing.create('house2', 'two bedrooms', 50),
        Listing.create('house3', 'terrace', 200)
      ]

      expect(Listing.all).to eq listings
    end
  end
end
