require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def setup
    @company = companies(:marcus_painting)
  end

  test "company should not be valid with email having other domains" do
    @company.email = "nitesh_test@new_painting.com"
    assert_not @company.valid?
    assert_equal "must be a mainstreet.com account"
  end
  
  test "company should be valid with getmainstreet email domain" do
    @company.email = "nitesh_test@getmainstreet.com"
    assert @company.valid?
  end

end