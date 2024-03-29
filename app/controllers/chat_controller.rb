class ChatController < ApplicationController
	before_filter :authorize_paid_user

	def get_user
		user = User.find(params[:id])
		respond_to do |format|
			format.json {
				render json: { user: {
					user_id: user.id,
				    user_name: user.full_name,
				    specialization: user.specialization,
			    profile_picture: user.get_profile_picture,
				    is_ignored: user.chat_ignored_by?(current_user.id)
				}}
			}
		end
	end

	def edit_options
		@user = current_user

		if params.include?(:user)
			if @user.update_attributes(chat_settings_params)
				flash[:success] = "Chat settings saved."
	      	end
		end

		render 'users/chat_options'
	end

	def get_history
		@messages = ChatMessage.lookup(current_user.id, params[:user_id]).order(created_at: :desc).page(params[:page]).per(15)

		respond_to do |format|
			format.json {
				final_messages = []
				@messages.each do |msg|
					final_messages.push({
						from_user_id: msg.from_user_id,
						to_user_id: msg.to_user_id,
						text: msg.body,
						time: msg.created_at
					})
				end
				render json: {
					messages: final_messages,
					show_more: !!@messages.next_page
				}
			}
		end
	end

	def get_online_users
		@users = User.where(nil)
		@users = @users.filter(params[:q]) if params[:q].present?
		@users = @users.online.chat_visible

		respond_to do |format|
			format.json {
				@final_users = []
				@users.each do |user|
				  @final_users.push({
				    user_id: user.id,
				    user_name: user.full_name,
				    specialization: user.specialization,
				    profile_picture: user.get_profile_picture,
				    is_ignored: user.chat_ignored_by?(current_user.id)
				  })
				end
				render json: {data: @final_users}
			}
		end
	end

	private
		def chat_settings_params
			params.require(:user).permit(:chat_is_invisible)
		end
end