# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "chris", email: "chris@hoge.com", password: "12345678")
User.create(name: "okabe", email: "okabe@hoge.com", password: "12345678")
User.create(name: "maho", email: "maho@hoge.com", password: "12345678")

require "faker/precure"

10.times do |n|
  # Element.create(name: Faker::RockBand.name)
  # Element.create(name: Faker::Precure.title)

  name = Faker::Precure.user_name
  email = name + "@hoge.com"
  password = "12345678"
  User.create(name: name, email: email, password: password)
end

User.all.each do |user|
  5.times do
    data = Faker::Precure.title
    element = Element.new(name: data)
    if element.save
      user.elements << Element.find_by(name: data)
    else
      if Element.exists?(name: element.name)     # Elementが既に存在する場合
        user.elements << Element.find_by(name: data) unless user.elements.exists?(name: element.name)
      end
    end
  end
end


# def add_elements(data, user)
#   element = Element.new(data)
#   if element.save
#     user.elements << Element.find_by(data)
#   else
#     if Element.exists?(name: element.name)     # Elementが既に存在する場合
#       user.elements << Element.find_by(data) unless user.elements.exists?(name: element.name)
#     end
#   end
# end
#
