class AddSummaryToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :summary, :text
  end
end
