class TapResearch::API

  module ClassMethods
    def api_email
      ::TAP_RESEARCH_CONFIG['api_email']
    end

    def api_token
      ::TAP_RESEARCH_CONFIG['api_token']
    end

    def api_uri
      ::TAP_RESEARCH_CONFIG['api_uri']
    end
  end

  extend ClassMethods

  include HTTParty

  basic_auth api_email, api_token
  base_uri   api_uri


  private

  def sql_mass_insert_or_update(table_name, keys, values)
    duplicate_update_keys = keys.collect{ |key| "#{key}=VALUES(#{key})" }
    "INSERT INTO #{table_name} (#{keys.join(",")}) VALUES #{values.join(",")} ON DUPLICATE KEY UPDATE #{duplicate_update_keys.join(",")}"
  end

  def sql_mass_insert_or_update_array(*array)
    result = array.collect do |element|
      case element.class.to_s
      when 'ActiveSupport::TimeWithZone', 'DateTime', 'String' then
        ActiveRecord::Base.sanitize(element.to_s)
      when 'Array' then
        ActiveRecord::Base.sanitize(element.join(','))
      else
        element
      end
    end
    "(#{result.join(',')})"
  end

end
