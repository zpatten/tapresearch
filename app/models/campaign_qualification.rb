class CampaignQualification < ActiveRecord::Base
  belongs_to :campaign_quota
end
