require './lib/user'
describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create('example@example.com', 'p@55w0rd')
      expect(user.id).not_to be_nil
    end
  end
end
