class RelationshipsController < ApplicationController
  def create
    will_follow = User.find(params[:user_id])
    if Relationship.exists?(followed_id: will_follow.id, follower_id: current_user.id)
      redirect_back fallback_location: users_path
    else
      new_rela = Relationship.new()
      new_rela.follower_id = current_user.id
      new_rela.followed_id = will_follow.id
      new_rela.save
      redirect_back fallback_location: users_path  
    end
  end

  def destroy
    will_unfollow = Relationship.where(followed_id: params[:user_id], follower_id: current_user.id)
    if will_unfollow.length == 0
      redirect_back fallback_location: users_path 
    else
      will_unfollow[0].destroy
      redirect_back fallback_location: users_path
    end
  end
end
