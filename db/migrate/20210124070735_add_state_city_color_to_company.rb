class AddStateCityColorToCompany < ActiveRecord::Migration[6.0]
  def change
  	add_column :companies, :city, :string
  	add_column :companies, :state, :string
     Company.all.each do |p|
       res = ZipCodes.identify(p.zip_code)
       p.city = res[:city] rescue "City"
       p.state = res[:state_name] rescue "State"
       p.save
     end
  end
end
