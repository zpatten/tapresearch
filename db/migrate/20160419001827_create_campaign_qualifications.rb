class CreateCampaignQualifications < ActiveRecord::Migration
  def change
    create_table :campaign_qualifications do |t|
      t.references :campaign_quota
      t.integer :question_id
      t.text :pre_codes
    end
  end
end
