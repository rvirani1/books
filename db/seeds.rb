# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_book(user, isbn)
  b = user.created_books.new(isbn: isbn)
  b.book_data_lookup
  b.save!
end

def create_user(count)
  User.create!(email: "example#{count}@mailinator.com", password: "password", confirmed_at: (1..5).to_a.sample.hour.ago)
end



u = create_user(1)
["0545010225", "0982986270", "1594633118", "0544272994", "1423146735", "0525953094", "0062220322", "1455582271"].each do |isbn|
  create_book(u, isbn)
end

u = create_user(2)
["0061122416", "014241543X", "1594206147", "0385345623", "080509668X", "0804178747", "0545685168"].each do |isbn|
  create_book(u, isbn)
end

u = create_user(3)
["1621572552", "1617690953", "1623363586", "0385539703", "1250054052", "0545685176", "1400065674"].each do |isbn|
  create_book(u, isbn)
end



