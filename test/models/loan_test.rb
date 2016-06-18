require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @loan = loans(:loan1)
  end

  # test 'test save' do
  #   puts @loan.mount
  #   @loan.mount = 50
  #   @loan.save
  #   puts @loan.reload.mount
  # end
end
