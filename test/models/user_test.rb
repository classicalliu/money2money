require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:foobar)
  end

  test 'name should be present' do
    @user.name = '  '
    assert_not @user.valid?
  end

  test 'sex should accept be 男 and 女' do
    @user.sex = '男'
    assert @user.valid?

    @user.sex = '女'
    assert @user.valid?
  end

  test 'sex should reject other than 男 or 女' do
    @user.sex = 'male'
    assert @user.invalid?
  end

  test 'phone_number less than 11 numbers' do
    # 10 numbers
    @user.phone_number = '1570008325'
    assert_not @user.valid?
  end

  test 'phone_number more than 11 numbers' do
    # 12 numbers
    @user.phone_number = '157000832500'
    assert_not @user.valid?
  end

  test 'invalid phone number should be reject' do
    @user.phone_number = '0' * 11
    assert_not @user.valid?
  end
end
