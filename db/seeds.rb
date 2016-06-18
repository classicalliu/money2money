# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

phone = '15700083250'

Admin.create!(email: 'foobar@example.com',
              password: 'password',
              name: '张雪',
              sex: '男',
              phone_number: phone)

Admin.create!(email: 'admin@example.com',
              password: 'password',
              name: '金成',
              sex: '男',
              phone_number: phone)

User.create!(email: 'foobar@example.com',
             password: 'password',
             password_confirmation: 'password',
             name: '张雪',
             sex: '女',
             phone_number: phone,
             address: '浙江工业大学屏峰校区')

password = 'password'
# password_confirmation = 'password'
# name = -> { Faker::Name.name }
sex = '男'
# phone_number = phone
# address = -> { add = Faker::Address; "#{add.state} #{add.city} #{add.street_address}" }
#
# mount = -> { (rand(50) + 50) * 100 }
# salary = mount

def phone_number
  # '15' + (0..9).to_a.shuffle[0...9].join
  '15' + [*(0..9)].sample(9).join
end

def name
  Faker::Name.name
end

def address
  add = Faker::Address
  "#{add.state} #{add.city} #{add.street_address}"
end

def mount
  (rand(50) + 50) * 100
end

def salary
  mount
end


15.times do |n|
  email = "example-#{n+1}@example.com"
  User.create!(
      email: email,
      password: password,
      password_confirmation: password,
      name: name,
      sex: sex,
      phone_number: phone_number,
      address: address
  )
end

users = User.all
20.times do
  users.each do |user|
    should_return = mount
    user.loans.create!(
        mount: should_return,
        way: '工资',
        use: '学费',
        period: rand(6) + 4,
        passed: 'no',
        job: '扫大街的',
        salary: 500,
        company_add: '浙工大',
        should_return: should_return * 1.1
    )
  end
end

20.times do
  users.each do |user|
    should_return = mount
    user.loans.create!(
        mount: should_return,
        way: '工资',
        use: '学费',
        period: rand(6) + 4,
        passed: 'yes',
        job: '扫大街的',
        salary: 500,
        company_add: '浙工大',
        should_return: should_return * 1.1
    )
  end
end

user = User.first
the_mount = mount
user.loans.create!(
    mount: the_mount,
    way: '工资',
    use: '学费',
    period: rand(6) + 4,
    passed: 'yes',
    already_mount: the_mount,
    fulled: true,
    should_return: the_mount * 1.1,
    job: '清洁阿姨',
    salary: 1000,
    company_add: '浙江工业大学'
)

loans = Loan.order(:created_at)
loans.each do |loan|
  loan.guarantors.create!(
      name: name,
      id_card: '123',
      sex: '男',
      phone_number: phone_number,
      address: address,
      job: '扫地的',
      salary: salary,
      relationship: '父亲'
  )

  loan.guarantors.create!(
      name: name,
      id_card: '123',
      sex: '女',
      phone_number: phone_number,
      address: address,
      job: '扫地的',
      salary: salary,
      relationship: '母亲'
  )

  loan.guarantors.create!(
      name: name,
      id_card: '123',
      sex: '男',
      phone_number: phone_number,
      address: address,
      job: '扫地的',
      salary: salary,
      relationship: '朋友'
  )
end