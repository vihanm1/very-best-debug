class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)
  
  if @the_venue.nil?
    # Handle the case where no venue was found with the provided ID
  else
    render({ :template => "venue_templates/venue_details" })
  end
end

  def create
    @venue = Venue.new
    @venue.address = params.fetch("query_address")
    @venue.name = params.fetch("query_name")
    @venue.neighborhood = params.fetch("query_neighborhood")
    @venue.save

    redirect_to("/venues/#{@venue.id}")
  end
  
  def update
    the_id = params.fetch("venue_id")

    @venue = Venue.find(the_id)
    @venue.address = params.fetch("query_address")
    @venue.name = params.fetch("query_name")  
    @venue.neighborhood = params.fetch("query_neighborhood")
    @venue.save
    
    redirect_to("/venues/#{@venue.id}")
  end

  def destroy
    the_id = params.fetch("venue_id")
    @venue = Venue.find(the_id)
    @venue.destroy

    redirect_to("/venues")
  end
end
