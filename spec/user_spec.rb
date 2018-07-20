require './lib/user'
require './spec/unit_spec_helper'
describe User do
  describe '.create' do
    it 'creates a new user' do
      user = create_new_user
      expect(user.id).not_to be_nil
      expect(user.name).to eq('name')
      expect(user.email).to eq('example@example.com')
      expect(user.password).not_to be_nil
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('p@55w0rd')
      create_new_user
    end
  end

  describe '.authenticate' do
    it 'returns a user given the correct email and password' do
      user = create_new_user
      authenticated_user = User.authenticate('example@example.com', 'p@55w0rd')
      expect(authenticated_user.id).to eq(user.id)
    end
    it 'returns nil given an unknown email address' do
      create_new_user
      expect(User.authenticate('bademail@example.com', 'p@55w0rd')).to be_nil
    end
    it 'returns nil given an unknown password' do
      create_new_user
      expect(User.authenticate('example@example.com', 'badpassword')).to be_nil
    end
  end
end
