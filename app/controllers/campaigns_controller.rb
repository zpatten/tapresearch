class CampaignsController < ApplicationController

  def ordered_campaigns
    campaigns = Campaign.includes(:campaign_qualifications).order("campaigns.cpi DESC, campaigns.length_of_interview ASC").all

    @ordered_questions = Hash.new { |hash,key| hash[key] = Array.new }

    campaigns.each do |campaign|
      if campaign.campaign_quotas.empty?
        @ordered_questions["Empty"] << campaign.name
        next
      end

      campaign.campaign_qualifications.each do |campaign_qualification|
        if (campaign_qualification.question_id == 43 && campaign_qualification.pre_codes.split(",").include?("2"))
          campaign_name = "<b>#{campaign.name}</b>"
        else
          campaign_name = campaign.name
        end
        @ordered_questions["List #{campaign_qualification.question_id}"] << campaign_name
      end
    end
  end

end
