module UsersHelper
	def avatar_for(user)
		link_to image_tag("/profile_pictures/#{user.get_profile_picture}", title: user.full_name, class: 'profile-avatar', alt: user.full_name), user
	end
end
