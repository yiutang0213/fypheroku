class ParkingspacesEvsocketsController < ApplicationController
	    layout "backend"
	before_action :find_venue
	before_action :find_parkingspace

	def index
		@evsockets = @parkingspace.evsockets
	end
	def show
		@evsocket = @parkingspace.evsockets.find( params[:id] )
	end
	def edit
		@evsocket = @parkingspace.evsockets.find( params[:id] )
	end
	def update
		@evsocket = @parkingspace.evsockets.find( params[:id] )
		if @evsocket.update( evsocket_params )
			redirect_to venue_parkingspace_evsockets_path(@venue,@parkingspace)
		else
			render :action => :edit
		end
	end
	def destroy
		@evsocket = @parkingspace.evsockets.find( params[:id] )
		@evsocket.destroy

		redirect_to venue_parkingspace_evsockets_path(@venue,@parkingspace)
	end
	def new
		@evsocket = @parkingspace.evsockets.new
	end

	def create
		@evsocket = @parkingspace.evsockets.new( evsocket_params )
		@evsocket.venue_id=@parkingspace.venue_id
		@evsocket.save
        ParkingspaceEvsocketship.create( :evsocket=> @evsocket, :parkingspace=> @parkingspace)
			redirect_to venue_parkingspace_evsockets_path(@venue,@parkingspace)

	end

	protected
	def find_venue
		@venue = Venue.find( params[:venue_id] )
	end
	def find_parkingspace
		@parkingspace = Parkingspace.find( params[:parkingspace_id] )
	end
	def evsocket_params
		params.require(:evsocket).permit(:evsocket_code,:evsocket_status,:evsocket_type,:venue_id)
	end
end
