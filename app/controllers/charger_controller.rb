class ChargerController < ApplicationController
	require 'rest-client'
	require 'json'
	require 'builder'
    layout "mainpage"

	def index
		if params[:type] =='bs1363'
			@evsocket_type = "evsocket_type = 0"
		elsif params[:type] == 'iec62196'
			@evsocket_type = "evsocket_type = 1"
		elsif params[:type] == 'saej1772'
			@evsocket_type = "evsocket_type = 2"			
		elsif params[:type] == 'chademo'
			@evsocket_type = "evsocket_type = 3"			
		elsif params[:type] == 'gb20234'
			@evsocket_type = "evsocket_type = 4"			
		elsif params[:type] == 'ccsdccombo'
			@evsocket_type = "evsocket_type = 5"			
		elsif params[:type] == 'teslawallconnector'
			@evsocket_type = "evsocket_type = 6"			
		elsif params[:type] == 'teslasupercharger'
			@evsocket_type = "evsocket_type = 7"					
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
			@ret["carpark_latitude"] = carpark.latitude
			@ret["carpark_longitude"] = carpark.longitude
			@ret["availability"] = "Occupied"
			@ret["available_parkingspace_no"]=0
			if Parkingspace.includes(:evsockets).where( :evsockets => { :evsocket_type => @evsocket_type,:evsocket_status =>'t' }, :parkingspaces=>{:parkingspace_status=>'t',:venue_id=>carpark.id} ).exists?
				@ret["availability"] = "Available"
				@ret["available_parkingspace_no"]=Parkingspace.includes(:evsockets).where( :evsockets => { :evsocket_type => @evsocket_type,:evsocket_status =>'t' }, :parkingspaces=>{:parkingspace_status=>'t',:venue_id=>carpark.id} ).count
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
       @carparks_ret=@carparks_hash2.sort_by { |b| b['est'].sub(/mins/, '').to_i}
      render json: @carparks_ret
     ##respond_to do |format|
     	##format.html { render layout: 'mainpage' }
     	##format.json { render json: @carparks_ret }
     ##end
 end
end
