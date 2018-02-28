class VenueParkingspacesController < ApplicationController
	before_action :find_venue
	    layout "backend"

	def index
		@parkingspaces = @venue.parkingspaces
	end

	def show
		@parkingspace = @venue.parkingspaces.find( params[:id] )
	end

	def new
		@parkingspace = @venue.parkingspaces.new
	end

	def create
		@parkingspace = @venue.parkingspaces.new( parkingspace_params )
		@parkingspace.save
		ParkingspaceEvsocketship.create( :evsocket=> @evsocket, :parkingspace=> @parkingspace)

		redirect_to venue_parkingspaces_url( @venue )
	end

	def edit
		@parkingspace = @venue.parkingspaces.find( params[:id] )
		ParkingspaceEvsocketship.create( :evsocket=> @evsocket, :parkingspace=> @parkingspace)

	end

	def update
		@parkingspace = @venue.parkingspaces.find( params[:id] )

		if @parkingspace.update( parkingspace_params )
			redirect_to venue_parkingspaces_url( @venue )
		else
			render :action => :edit
		end

	end

	def destroy
		@parkingspace = @venue.parkingspaces.find( params[:id] )
		@parkingspace.destroy

		redirect_to venue_parkingspaces_url( @venue )
	end

	protected

	def find_venue
		@venue = Venue.find( params[:venue_id] )
	end

	def parkingspace_params
		params.require(:parkingspace).permit(:parkingspace_no,:parkingspace_status,:venue_id,:evsocket_ids=>[])
	end
end
