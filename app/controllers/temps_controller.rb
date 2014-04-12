class TempsController < ApplicationController

  def index
  	session[:time] = Time.now
  	# cookies[:login] = {:name => session}
  	# user_cookie[:login] = { value: [1,2,3], expires: Time.now + 1}
  	# @session = Session.new
  	# @session.session_id = session
  	# @session.data[:score] = [true, false, true, true]
  	# puts "The session is #{@session}"
  end

  def new
  	binding.pry
  	puts "User info: #{cookies[:name]}"
  	puts "User score is: #{cookies[:expires]}"
  end 


end
