def create_new_user
User.create('name', 'example@example.com', 'p@55w0rd')
end
