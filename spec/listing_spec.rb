require 'listing'

describe Listing do
  describe '.create' do
    it 'creates a new listing' do
      listing = Listing.create('house', 'nice garden', 100, 4)
      expect(listing.id).not_to be_nil
    end
  end

  describe '.all' do
    it 'returns all listings' do
      listings = [
        Listing.create('house1', 'nice garden', 100, 1),
        Listing.create('house2', 'two bedrooms', 50, 2),
        Listing.create('house3', 'terrace', 200, 3)
      ]

      expect(Listing.all).to eq listings
    end
  end
end
