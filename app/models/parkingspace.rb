class Parkingspace < ApplicationRecord
	belongs_to :venue
	has_many :parkingspace_evsocketships
    has_many :evsockets, :through => :parkingspace_evsocketships
end
