class CreateCampaignQualifications < ActiveRecord::Migration
  def change
    create_table :campaign_qualifications, :id => false do |t|
      t.references :campaign_quota
      t.integer :question_id
      t.text :pre_codes
    end
    add_index :campaign_qualifications, [:campaign_quota_id, :question_id], :unique => true, :name => 'campaign_quota_id_and_question_id'
  end
end
