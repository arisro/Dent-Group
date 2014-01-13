class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
    	t.integer :user_id

    	t.string :title
    	t.text :description
    	t.string :company_name
    	t.string :country
    	t.string :city

    	t.integer :type
    	t.integer :count
    	t.string :offer
    	t.datetime :valid_until
    	
		t.timestamps
    end
  end
end
