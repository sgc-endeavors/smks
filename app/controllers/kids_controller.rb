class KidsController < ApplicationController

def new
@new_kid = Kid.new
render :new
end

def create
new_kid = Kid.new(params[:kid])
new_kid.user_id = current_user.id
new_kid.save!
redirect_to stories_path
end


end
