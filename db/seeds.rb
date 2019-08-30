# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roop_count = 40

AdminUser.create(email:"test@gmail.com", password: "admin0212")

roop_count.times do |i|
  Genre.create(genre_name: "genre#{i+1}")
  Label.create(label_name: "label#{i+1}")
  Artist.create(artist_name: "artist#{i+1}")
end

roop_count.times do |i|
  img = File.open("./app/assets/images/music.jpeg")
  sale_c = 0
  st = i+1
  if (i+1)% 7 == 0
    sale_c = 1
  end
  if (i+1)% 9 == 0
    st = 0
  end
  item = Item.create(artist_id: i+1, genre_id: i+1, label_id: i+1, item_name: "test#{i+1}", price: 100*(i+1), stock: st, sale_number: i, sale_condition: sale_c, item_image: img)
  disc = Disc.create(item_id: item['id'], disc_number: 1)
  Music.create(disc_id: disc['id'], music_order: 1, music_name: "test#{i+1}")
end

roop_count.times do |i|
  end_user = EndUser.create(email:"test#{i+1}@gmail.com", password: "end0212", last_name: "山田#{i+1}", first_name: "太郎#{i+1}", last_name_kana: "ヤマダ#{i+1}", first_name_kana: "タロウ#{i+1}", delete_flag: false, usually_payment: 0 )
  Address.create(end_user_id: end_user['id'], address: '京都府', name: '山田太郎', postal_code: "6101111", telephone_number: '08033332222', main_flag: true)
  Address.create(end_user_id: end_user['id'], address: '大阪府', name: '出口二郎', postal_code: "7108911", telephone_number: '09044445555', main_flag: false)
  Address.create(end_user_id: end_user['id'], address: '北海道', name: '森本三郎', postal_code: "3105111", telephone_number: '07088886666', main_flag: false )
end