class RatingsController < ApplicationController

def create
	story_id = params[:t_up] || params[:t_down]
	rating = Rating.new
 	if params[:t_up]
		rating.name = "thumbs up"
	elsif params[:t_down]
		rating.name = "thumbs down"
	end
		rating.story_id = story_id
		rating.user_id = current_user.id
		rating.save!
		redirect_to stories_path
end

# def update
# 	end


end


# <%
# 	if @rating.id == nil
# 	route = "/ratings"
# 	methods = "post"
# 	else
# 	route = "/ratings/#{@rating.id}"
# 	methods = "put"
# 	end%>

# <%= form_for(@rating, url: route) do |f| %> 

# 	<%= button_tag "Thumbs Up", name: "t_up", value: @existing_story.id %>
# 	<%= button_tag "Thumbs Down", name: "t_down", value: @existing_story.id %>
	
		
# 	<%end%>