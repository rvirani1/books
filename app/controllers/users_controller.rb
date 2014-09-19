class UsersController < ApplicationController
  # before_filter :set_json_format
  return_json except: [:friendships]

  def friend
    current_user.friend!(User.find params[:id])
    # Send back an empty response - no content, just not an error
    head :ok
  end

  def unfriend
    current_user.unfriend!(User.find params[:id])
    head :ok
  end

  def index
    @users = User.all
    # render :index
  end

  def friends
    @users = current_user.friends
    render :index
  end

  def friendships
    @friends = current_user.friends
  end

end
