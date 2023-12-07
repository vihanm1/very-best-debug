class UsersController < ApplicationController

  def homepage
    @users = User.where({})
    render({ :template => "user_templates/all_users" })
  end
  
  def index
    matching_users = User.all
    @users = matching_users.order(:created_at)

    render({ :template => "user_templates/all_users" })
  end
  
  def show
    username = params.fetch("username")
    @user = User.where({ :username => username }).at(0)
    
    if @user
      render({ :template => "user_templates/user_details" })
    else
      # Handle the case where the user is not found
    end
  end
  
  def create
    user = User.new
    user.username = params.fetch("query_username")
    user.save
    
    redirect_to("/users/#{user.username}")
  end
  
  def update
    user_id = params.fetch("user_id")
    matching_users = User.where({ :id => user_id })
    the_user = matching_users.first
    
    the_user.username = params.fetch("query_username")
    the_user.save
    redirect_to("/users/#{the_user.username}")
  end

end
