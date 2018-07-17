require 'listing'

describe Listing do
  describe '.create' do
    it 'creates a new listing' do
      listing = Listing.create('house', 'nice garden', 100)
      expect(listing.id).not_to be_nil
    end
  end
end
