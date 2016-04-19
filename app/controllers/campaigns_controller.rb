class CampaignsController < ApplicationController

  def ordered_campaigns
    @campaigns = Campaign.order(:id).all

    render :json => @campaigns
  end

end
