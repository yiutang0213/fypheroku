class UploadfromarduinoController < ApplicationController
	require 'rest-client'
	require 'json'
	require 'builder'
	def index
		@uploadsituation = [];
		if params[:key]="Zhugirf3h4578g3yuisx7g45h"
			then
			@parkingspaceid=0
			if params[:parkingspaceid]
				@parkingspaceid=params[:parkingspaceid]
				@parkingspacestatus = params[:Pstatus]
				editparkingspace = Parkingspace.where({:id => @parkingspaceid}).first
				editparkingspace.parkingspace_status=params[:Pstatus]
				editparkingspace.save
				@ret ={}
				@ret["parkingspace_id"]=@parkingspaceid
				@ret["parkingspace_status"]=@parkingspacestatus
				@ret["status"]="upload successful"
			end
		else
			@ret["status"]="upload failed."
		end
		@uploadsituation.append(@ret)
		render json: @uploadsituation
	end
end
