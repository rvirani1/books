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
    @users = User.all - User.where(id: current_user.id)
  end

  def friends
    @friends = current_user.friends
  end

  def friendships
    #@friends = current_user.friends
  end

  def requests
    @requests = current_user.requests
  end

  def show
  end
end
