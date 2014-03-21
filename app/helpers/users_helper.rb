module UsersHelper
	def avatar_for(user)
		link_to image_tag("/profile_pictures/#{user.get_profile_picture}", title: user.full_name, class: 'profile-avatar', alt: user.full_name), user
	end
	def location_for(user)
		location = user.city
		if !location.empty? && !user.country.empty?
			location = "#{location}, #{user.country}"
		end
		return location
	end
end
