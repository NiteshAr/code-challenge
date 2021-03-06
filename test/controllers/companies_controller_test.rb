require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_equal '#28a745', @company.brand_color
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      fill_in('company_color', with: '#e4f6a5')
      fill_in("company_email", with: "hometown_painting@getmainstreet.com")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
    assert_equal 'CA', @company.state
    assert_equal 'Ventura', @company.city
    assert_equal '#e4f6a5', @company.color
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "Nitesh Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "1010101010")
      fill_in("company_email", with: "nitesh_test@getmainstreet.com")
      fill_in('company_color', with: '#d821c3')
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "Nitesh Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
    assert_equal 'NC', last_company.state
    assert_equal 'Waxhaw', last_company.city
    assert_equal '#d821c3', last_company.color
  end

  test 'Destroy' do
    name = @company.name
    visit companies_path
    count = Company.count

    find_all('#delete_company')[0].click
    page.driver.browser.switch_to.alert.accept

    assert_equal(Company.count, count - 1)
  end

end