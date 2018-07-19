require './lib/user'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create('example@example.com', 'p@55w0rd')
      expect(user.id).not_to be_nil
    end
  end

  describe '.authenticate' do
    it 'returns a user given the correct email and password' do
      user = User.create('example@example.com', 'p@55w0rd')
      authenticated_user = User.authenticate('example@example.com', 'p@55w0rd')
      expect(authenticated_user.id).to eq(user.id)
    end
  end
end
