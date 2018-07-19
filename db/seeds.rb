require 'faker'

users = Array.new()
users.push(
  {id: 1, email: "thangck94@gmail.com", password: "123456", is_admin: true, full_name: "Chử Kim Thắng"},
  {id: 2, email: "loick96@gmail.com", password: "123456", is_admin: false, full_name: "Chử Kim Lợi"},
  {id: 3, email: "phuld96@gmail.com", password: "123456", is_admin: false, full_name: "Lưu Đức Phú"},
  {id: 4, email: "thangndq94@gmail.com", password: "123456", is_admin: false, full_name: "Nguyễn Doãn Quyết Thắng"}
)
User.create(users)

groups = Array.new()
groups.push(
  {id: 1, name: "Thắng Lợi Thắng Phú Group", create_by_user: 1, saved_money: 0}
)
Group.create(groups)

categories = Array.new()
categories.push(
  {id: 1, name: "Nhà trọ"},
  {id: 2, name: "Thức ăn"},
  {id: 3, name: "Gia vị"},
  {id: 4, name: "Đồ dùng"}
)
Category.create(categories)

products = Array.new()
products.push(
  {id: 1, name: "Tiền nhà", is_shared: true, category_id: 1},
  {id: 2, name: "Tiền điện", is_shared: true, category_id: 1},
  {id: 3, name: "Tiền nước", is_shared: true, category_id: 1},
  {id: 4, name: "Tiền vệ sinh", is_shared: true, category_id: 1},
  {id: 5, name: "Tiền mạng", is_shared: true, category_id: 1},

  {id: 6, name: "Thịt", is_shared: true, category_id: 2},
  {id: 7, name: "Cá", is_shared: true, category_id: 2},
  {id: 8, name: "Trứng", is_shared: true, category_id: 2},
  {id: 9, name: "Tôm", is_shared: true, category_id: 2},
  {id: 10, name: "Gạo", is_shared: true, category_id: 2},
  {id: 11, name: "Hoa qủa", is_shared: true, category_id: 2},
  {id: 12, name: "Rau", is_shared: true, category_id: 2},

  {id: 13, name: "Nước mắm", is_shared: true, category_id: 3},
  {id: 14, name: "Mì chính", is_shared: true, category_id: 3},
  {id: 15, name: "Bột canh", is_shared: true, category_id: 3},
  {id: 16, name: "Dầu ăn", is_shared: true, category_id: 3},
  {id: 17, name: "Tương ớt", is_shared: true, category_id: 3},

  {id: 18, name: "Dầu gội", is_shared: true, category_id: 4},
  {id: 19, name: "Xà phòng tắm", is_shared: true, category_id: 4},
  {id: 20, name: "Bột giặt", is_shared: true, category_id: 4}
)
Product.create(products)

user_groups = Array.new()
user_groups.push(
  {id: 1, user_id: 1, group_id: 1},
  {id: 2, user_id: 2, group_id: 1},
  {id: 3, user_id: 3, group_id: 1},
  {id: 4, user_id: 4, group_id: 1}
)
GroupMember.create(user_groups)

transactions = Array.new
(0..1000).each do |i|
  transactions.push({
    amount: Faker::Number.between(10000, 500000), 
    description: Faker::StarWars.character, 
    category_id: Faker::Number.between(0, 4), 
    group_id: 1,
    type_id: Faker::Number.between(1, 2),
    user_id: Faker::Number.between(1, 4),
    updated_at: Faker::Date.between(6.months.ago, Date.today)
  })
end
Transaction.create(transactions)
