module TapResearch::API::Campaign::Qualification

  def campaign_qualification_columns
    %w( campaign_quota_id question_id pre_codes )
  end

  def build_campaign_qualification_dataset(campaign, campaign_qualification_dataset)
    campaign['campaign_quotas'].each do |campaign_quota|
      campaign_quota['campaign_qualifications'].each do |campaign_qualification|
        campaign_qualification.merge!('campaign_quota_id' => campaign_quota['id'])

        campaign_qualification_column_data = Array.new

        campaign_qualification_columns.each do |campaign_qualification_column|
          campaign_qualification_column_data << campaign_qualification[campaign_qualification_column]
        end

        campaign_qualification_dataset << sql_mass_insert_or_update_array(*campaign_qualification_column_data)
      end
    end

    campaign_qualification_dataset
  end

  def build_campaign_qualification_sql(campaign_qualification_dataset)
    sql_mass_insert_or_update(::CampaignQualification.table_name, campaign_qualification_columns, campaign_qualification_dataset)
  end

end
