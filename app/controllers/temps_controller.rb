class TempsController < ApplicationController

  def index
  	@session = Session.new
  	@session.session_id = session
  	puts "The session is #{@session}"
  end

end
