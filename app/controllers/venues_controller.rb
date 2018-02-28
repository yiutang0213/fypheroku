class VenuesController < ApplicationController
	    layout "backend"
	def index
		@venues = Venue.all
	end
	def new
		@venue = Venue.new
	end
	def create
		@venue = Venue.new(venue_params)
		@venue.save

		redirect_to venues_path
	end
	def show
		@venue = Venue.find(params[:id])
		@page_title = @venue.name
	end
	def edit
		@venue = Venue.find(params[:id])
		@page_title = @venue.name
	end
	def update
		@venue = Venue.find(params[:id])
		@venue.update(venue_params)

		redirect_to venue_path(@venue)
	end
	def destroy
		@venue = Venue.find(params[:id])
		@venue.destroy

		redirect_to venues_path
	end

	private
	def venue_params
		params.require(:venue).permit(:name, :address,:charger_fee,:parking_fee,:latitude,:longitude)
	end
end
