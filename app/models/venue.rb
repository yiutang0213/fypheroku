class Venue < ApplicationRecord
	validates_presence_of :name
	has_many :parkingspaces
	has_many :evsockets
end
