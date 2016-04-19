module TapResearch::API::Campaign::Quota

  def campaign_quota_columns
    %w( id campaign_id )
  end

  def build_campaign_quota_dataset(campaign, campaign_quota_dataset)
    campaign['campaign_quotas'].each do |campaign_quota|
      campaign_quota.merge!('campaign_id' => campaign['id'])

      campaign_quota_column_data = Array.new

      campaign_quota_columns.each do |campaign_quota_column|
        campaign_quota_column_data << campaign_quota[campaign_quota_column]
      end

      campaign_quota_dataset << sql_mass_insert_or_update_array(*campaign_quota_column_data)
    end

    campaign_quota_dataset
  end

  def build_campaign_quota_sql(campaign_quota_dataset)
    sql_mass_insert_or_update(::CampaignQuota.table_name, campaign_quota_columns, campaign_quota_dataset)
  end

end
