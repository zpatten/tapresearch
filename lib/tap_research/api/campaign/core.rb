module TapResearch::API::Campaign::Core

  def campaign_columns
    %w( id name cpi length_of_interview )
  end

  def build_campaign_dataset(campaign, campaign_dataset)
    campaign_column_data = Array.new

    campaign_columns.each do |campaign_column|
      campaign_column_data << campaign[campaign_column]
    end

    campaign_dataset << sql_mass_insert_or_update_array(*campaign_column_data)

    campaign_dataset
  end

  def build_campaign_sql(campaign_dataset)
    result = sql_mass_insert_or_update(::Campaign.table_name, campaign_columns, campaign_dataset)

    puts("=" * 80)
    puts result.inspect

    result
  end

end
