class CreateCampaignQuota < ActiveRecord::Migration
  def change
    create_table :campaign_quota do |t|
      t.references :campaign
    end
  end
end
