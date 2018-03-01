class ChargerController < ApplicationController
	require 'rest-client'
	require 'json'
	require 'builder'
    layout "mainpage"

	def index
		if params[:type] =='bs1363'
			@evsocket_type = "evsocket_type = 0"
			@page_title = "BS 1363 "
		elsif params[:type] == 'iec62196'
			@evsocket_type = "evsocket_type = 1"
			@page_title = "IEC 62196"
		elsif params[:type] == 'saej1772'
			@evsocket_type = "evsocket_type = 2"			
			@page_title = "SAE J1772"
		elsif params[:type] == 'chademo'
			@evsocket_type = "evsocket_type = 3"			
			@page_title = "CHAdeMO"
		elsif params[:type] == 'gb20234'
			@evsocket_type = "evsocket_type = 4"			
			@page_title = "GB 20234.2"
		elsif params[:type] == 'ccsdccombo'
			@evsocket_type = "evsocket_type = 5"			
			@page_title = "CCS DC COMBO"
		elsif params[:type] == 'teslawallconnector'
			@evsocket_type = "evsocket_type = 6"			
			@page_title = "Tesla wall connector"
		elsif params[:type] == 'teslasupercharger'
			@evsocket_type = "evsocket_type = 7"					
			@page_title = "Tesla Supercharger"	
		end

		@carparks = Venue.joins(parkingspaces: :evsockets).where(@evsocket_type).group("venues.id")
		@carparks_hash1 = []
		@carparks_hash2 = []
		@carparks_ret = [];
		@carparks.each do |carpark|
			@ret = {}
			@ret["name"] = carpark.name
			@ret["address"] = carpark.address
			@ret["charger_fee"] = carpark.charger_fee
			@ret["parking_fee"] = carpark.parking_fee
			@ret["availability"] = "Occupied"
			if Parkingspace.includes(:evsockets).where( :evsockets => { :evsocket_type => @evsocket_type,:evsocket_status =>'t' }, :parkingspaces=>{:parkingspace_status=>'t',:venue_id=>carpark.id} ).exists?
				@ret["availability"] = "Available"
			end
			@lat = 0
			@lon = 0
			if params[:lat]
				@lat=params[:lat]
			end
			if params[:lon]
				@lon=params[:lon]
			end

			@ret["est"] = "N/A"
			if carpark.latitude && @lat && @lon
				@url = "https://maps.googleapis.com/maps/api/directions/json?origin="+@lat.to_s+","+@lon.to_s+"&destination=" + carpark.latitude.to_s + "," + carpark.longitude.to_s + "&key=AIzaSyAXyeT9DZpFtxbLAMWqvSVQuPS7gStNNkE"
				@response = RestClient.get(@url)
				@locationinfo=JSON.parse(@response.body)
				if @locationinfo["status"]=="OK"
					@ret["est"] = @locationinfo["routes"][0]["legs"][0]["duration"]["text"]
				end
			end
            ##@ret["user_let"] = -22.013225
            @carparks_hash1.append(@ret)
        end
       ## @carparks_ret.sort
       @carparks_hash2=@carparks_hash1.sort_by { |a| a[:availability]}.reverse
       @carparks_ret=@carparks_hash2.sort_by { |b| b[:est]}
      render json: @carparks_ret
     ##respond_to do |format|
     	##format.html { render layout: 'mainpage' }
     	##format.json { render json: @carparks_ret }
     ##end
 end
end