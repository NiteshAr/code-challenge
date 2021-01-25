class AddColomnBrandNameToCpmpany < ActiveRecord::Migration[6.0]
  def change
  	add_column :companies, :brand_color, :string, default_value: '#000000'
  end
end
