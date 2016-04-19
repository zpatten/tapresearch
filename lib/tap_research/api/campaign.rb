class TapResearch::API::Campaign < TapResearch::API

  def all
    response = self.class.get("/campaigns")

    JSON.parse(response.body)
  end

  def get(id)
    response = self.class.get("/campaigns/#{id}")

    JSON.parse(response.body)
  end

  def sync
    campaign_dataset = Array.new
    campaign_quota_dataset = Array.new
    campaign_qualification_dataset = Array.new

    remote_campaigns = self.all
    remote_campaigns.each do |remote_campaign|
      remote_campaign = self.get(remote_campaign['id'])

      puts("-" * 80)
      puts remote_campaign.inspect

      campaign_dataset = build_campaign_dataset(remote_campaign, campaign_dataset)
      campaign_quota_dataset = build_campaign_quota_dataset(remote_campaign, campaign_quota_dataset)
      campaign_qualification_dataset = build_campaign_qualification_dataset(remote_campaign, campaign_qualification_dataset)
    end

    campaign_sql_statement = build_campaign_sql(campaign_dataset)
    campaign_quota_sql_statement = build_campaign_quota_sql(campaign_quota_dataset)
    campaign_qualification_sql_statement = build_campaign_qualification_sql(campaign_qualification_dataset)

    ActiveRecord::Base.transaction do
      ::Campaign.connection.execute(campaign_sql_statement)
      ::CampaignQuota.connection.execute(campaign_quota_sql_statement)
      ::CampaignQualification.connection.execute(campaign_qualification_sql_statement)
    end

  end

  private

  include TapResearch::API::Campaign::Core
  include TapResearch::API::Campaign::Quota
  include TapResearch::API::Campaign::Qualification

end
