module ApplicationHelper
	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	def current_country
		session[:current_country]
	end

	def chat_url
		if Rails.env.production?

		else
			
		end
	end

	def put_active_menu(current_menu)
		where = 'homepage'

		case params[:controller]
		when 'jobs'
			where = 'jobs'
		when 'users'
			where = 'my_profile' if params[:action] == 'feed'
		when 'bad_customers'
			where = 'customers'
		when 'offers'
			where = 'offers'
		when 'news'
			where = 'news'
		when 'static_pages'	
			where = 'about' if params[:action] == 'about'
		when 'suppliers'
			where = 'suppliers'
		else
			where = 'homepage'
		end

		current_menu == where ? 'active' : ''
	end

	def current_user?(user)
		user.id == current_user.id
	end
end
