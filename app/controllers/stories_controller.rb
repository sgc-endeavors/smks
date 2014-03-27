class StoriesController < ApplicationController
	before_filter :authenticate_user!, except: [ :home, :index, :show, :about ]

 def home
 	if user_signed_in?
 		@image = Image.where(user_id: current_user.id).where(show_on_homepage: true).first
 	end
 	render :home
 end

 def about
 	render :about
 end

 def index
 	unless current_user == nil
 		@draft_stories_count = Story.where(status: "draft").where(user_id: current_user.id).count
 	end

	@type = params[:type]
 	if params[:type] == "public" || params[:type] == nil
 		@existing_stories = Story.where(share_type: "public").where(status: "published").order("published_date desc")	
		@top_stories = Story.joins(:ratings).group("stories.id").count("ratings.id").sort
 	elsif params[:type] == "personal"
		@existing_stories = Story.where(status: "published").where(user_id: current_user.id).order("date_occurred desc")
	elsif params[:type] == "shared"
		wanted_users_friends = current_user.inverse_friendships.where(hide_content: false).map(&:user_id)
		all_shared_stories = Story.where(user_id: current_user.id).where(status: "published").where("share_type not like 'private'") + Story.where(user_id: wanted_users_friends).where(status: "published").where("share_type not like 'private'")
		@existing_stories = all_shared_stories.sort_by { |story| story.published_date.to_i * -1 }

 			#@existing_stories = Story.where(user_id: friendships).where(status: "published").where("share_type not like 'private'") + Story.where(user_id: current_user.id).where(status: "published").where("share_type not like 'private'") 
 	elsif params[:type] == "draft"
		@existing_stories = Story.where(status: "draft").where(user_id: current_user.id).order("id desc")
 	end
 	render :index
 end

 def new #(get)
 	@new_story = Story.new
 	@person_name = Person.new
	@share_type = User.find(current_user.id).default_share_preference
 	render :new
 end

 def create #(post)
 	new_story = Story.new(params[:story])
 	#new_story.person_id = Person.where(name: params[:person_name]).where(user_id: current_user.id).first.id
 	new_story.user_id = current_user.id
 	new_story.date_occurred = params[:date_occurred]

 	if params[:publish]
 		new_story.status = "published"
 		new_story.published_date = Time.now.to_datetime
 	else
 		new_story.status = "draft"
 	end
 	new_story.save!
 	
 	if params[:s3_image_loc]	 	
 		new_image = Image.new
	 	new_image.s3_image_loc = params[:s3_image_loc]
	 	new_image.user_id = current_user.id
	 	new_image.story_id = new_story.id
	 	new_image.save!
 	end
 	redirect_to story_path(new_story)
 end

	def show #(get)

		@type = params[:type]
	 	@existing_story = Story.find(params[:id])


	 	if @existing_story.date_occurred && @existing_story.person.birthdate
	 		@age = "- Age: #{@existing_story.calculate_story_age}"
	 	end

	 	if @type == "public" || @type == nil
 			@next_story = Story.where(share_type: "public").where(status: "published").order(:id).where("id > #{params[:id].to_i}").first
			@previous_story = Story.where(share_type: "public").where(status: "published").order(:id).where("id < #{params[:id].to_i}").last	 			
	 	elsif @type == "personal"
	 		#date = DateTime.strptime()
			@next_story = Story.where(status: "published").where(user_id: current_user.id).where("date_occurred" => @existing_story.date_occurred.."2099-01-01".to_datetime).where("id != ?", @existing_story.id).order("date_occurred").first
			@previous_story = Story.where(status: "published").where(user_id: current_user.id).where("date_occurred" => "1000-01-01".to_datetime..@existing_story.date_occurred).where("id != ?", @existing_story.id).order("date_occurred desc").first
	 	
		elsif @type == "shared"
			@shared_stories = Story.where(user_id: current_user.id).where(status: "published").where("share_type not like 'private'") + Story.where(user_id: current_user.inverse_friends).where(status: "published").where("share_type not like 'private'")
			@sorted_stories = @shared_stories.sort_by { |story| story.published_date.to_i * -1 }
			@next_story = @sorted_stories[@sorted_stories.find_index { |item| item.id == @existing_story.id} - 1]
			@previous_story = @sorted_stories[@sorted_stories.find_index { |item| item.id == @existing_story.id} + 1]

	 	end

	 
	 	@remarks = Remark.where(story_id: @existing_story.id)

		###### NEED TO ADD TEST SO THAT YOU CAN NOT BACKDOOR SOMEONES STORY VIA TYPING IN THE URL
		#CURRENTLY YOU CAN.
	 	#authorize! :read, @existing_story <<<< need to be so that you can only access public/published stories

	 	render :show
	end

	def edit #(get)
		@current_story = Story.find(params[:id])
		@share_type = @current_story.share_type
		@person_name = if @current_story.person
			@current_story.person.name
		else
			nil
		end

		# if @current_story.person != nil
		# 	@person_name = @current_story.person.name
		# else
		# 	@person_name = nil
		# end

		authorize! :update, @current_story
		render :edit
	end

	def update #(post/put)
		updated_story = Story.find(params[:id])
		updated_story.update_attributes(params[:story])

		if params[:publish]
 			updated_story.status = "published"
 			if updated_story.published_date == nil
 				updated_story.published_date = Time.now.to_datetime
 			end
 		else
 			updated_story.status = "draft"
 		end
 		#updated_story.person_id = Person.where(name: params[:person_name]).where(user_id: current_user.id).first.id
 		updated_story.date_occurred = params[:date_occurred]
 		updated_story.save!
		redirect_to story_path(updated_story)
	end

	def destroy #(post/delete)
		current_user.stories.find(params[:id]).destroy
		redirect_to stories_path(type: "personal")
	end
end

