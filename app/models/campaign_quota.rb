class CampaignQuota < ActiveRecord::Base
  belongs_to :campaign
  has_many :campaign_qualifications
end
