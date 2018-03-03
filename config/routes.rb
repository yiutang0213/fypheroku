Rails.application.routes.draw do
	resources :venues do
		resources :parkingspaces, :controller => 'venue_parkingspaces'do
		resources :evsockets, :controller => 'parkingspaces_evsockets' 
	end
end
root 'charger#mainview'
resources :charger
resources :uploadfromarduino

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
