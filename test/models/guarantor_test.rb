require 'test_helper'

class GuarantorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @guarantor = guarantors(:foobar)
    # @guarantor = Guarantor.new(
    #                 name: 'foobar',
    #                 phone_number: '15700083670',
    #                 salary: 20.00,
    #                 sex: 'male',
    #                 address: '浙江工业大学',
    #                 id_card: '123456',
    #                 job: '程序猿',
    #                 relationship: '朋友',
    # )
  end

  test 'guarantor should be valid' do
    assert @guarantor.valid?
  end

  test 'name should be presence' do
    @guarantor.name = ' '
    assert_not @guarantor.valid?
  end

  test 'phone_number should be a number' do
    @guarantor.phone_number = '12345678901'
    assert_not @guarantor.valid?
  end

  test 'phone number can not less than 11 numbers' do
    @guarantor.phone_number = '1570008367'
    assert_not @guarantor.valid?
  end

  test 'phone number can not more than 11 numbers' do
    @guarantor.phone_number = '157000836700'
    # assert_not @guarantor.valid?
    assert @guarantor.invalid?
  end

  test 'salary must greater than or equal to  0' do
    @guarantor.salary = -1
    assert_not @guarantor.valid?
    @guarantor.salary = 0
    assert @guarantor.valid?
  end

  # test 'salary can not have more than 2 decimal' do
  #   # @guarantor.salary = 0.913343
  #   @guarantor.salary = 'foobar'
  #   assert_not @guarantor.valid?
  #   # assert_not @guarantor.save
  # end

end
