module ApplicationHelper
	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	def put_active_menu(current_menu)
		where = nil
		case params[:controller]
		when 'jobs'
			where = 'jobs'
		else
			where = 'home'
		end

		current_menu == where ? 'active' : ''
	end
end
