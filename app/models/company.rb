class Company < ApplicationRecord
  has_rich_text :description

  after_commit :update_city_state, 
  if: proc { |record| 
    record.previous_changes.key?(:zip_code) &&
      record.previous_changes[:zip_code].first != record.previous_changes[:zip_code].last
  }

  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@getmainstreet\.com\z/,
                  message: "must be a mainstreet.com account" }


                  def update_city_state
                  	res = ZipCodes.identify(self.zip_code)
                    if res.nil?
                      self.city =  "City"
                      self.state =  "State"
                    else
                    	self.city = res[:city]
                    	self.state = res[:state_name]
                    end
                      self.save
                  end

end
