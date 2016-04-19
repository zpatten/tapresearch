class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.string :cpi
      t.integer :length_of_interview
    end
  end
end
