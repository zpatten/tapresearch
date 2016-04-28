class Campaign < ActiveRecord::Base
  has_many :campaign_quotas
  has_many :campaign_qualifications, :through => :campaign_quotas
end
