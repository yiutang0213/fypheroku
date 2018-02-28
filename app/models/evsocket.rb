class Evsocket < ApplicationRecord
	has_many :parkingspace_evsocketships
    has_many :parkingspaces, :through => :parkingspace_evsocketships
    belongs_to :venue
end
