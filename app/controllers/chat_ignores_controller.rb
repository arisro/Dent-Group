class ChatIgnoresController < ApplicationController
	respond_to :json

	def index
		@chat_ignores = current_user.chat_ignores
	end

	def create
		@ignore = ChatIgnore.new(by_user_id: current_user.id, on_user_id: params[:user_id])
		respond_to do |format|
			if @ignore.save
				Rails.cache.delete("chat/are_ignored/#{current_user.id}/#{params[:user_id]}")
				Rails.cache.delete("chat/are_ignored/#{params[:user_id]}/#{current_user.id}")
				
				format.json { head :ok }
			else
				format.json { render :json => @ignore.errors, :status => :unprocessable_entity }
			end
		end
	end

	def destroy
		@ignore = ChatIgnore.lookup(current_user.id, params[:id]).first
		raise ActiveRecord::RecordNotFound if @ignore.nil?
		@ignore.destroy
		Rails.cache.delete("chat/are_ignored/#{current_user.id}/#{params[:id]}")
		Rails.cache.delete("chat/are_ignored/#{params[:id]}/#{current_user.id}")

		respond_to do |format|
			format.json { head :ok }
			format.html { redirect_to chat_ignores_path }
		end
	end
end