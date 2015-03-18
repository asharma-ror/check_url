require "check_url/version"
require 'addressable/uri'
require 'httpi'
require 'active_support/core_ext/hash/except'
require 'active_model/validator'
require 'active_support/core_ext/array/wrap'

class HasUrl < ActiveModel::EachValidator
      
  def validate_each(record, attribute, value)
    return if value.blank?

    begin
      uri = Addressable::URI.parse(value)
      if uri.scheme.nil? and options[:default_scheme] then
        uri = Addressable::URI.parse("#{options[:default_scheme]}://#{value}")
      end
    rescue Addressable::URI::InvalidURIError
      record.errors.add(attribute, options[:invalid_url_message] || :invalid_url) unless http_url_format_valid?(uri)
      return
    end
    
    record.errors.add(attribute, options[:invalid_url_message]          || :invalid_url)          unless http_url_format_valid?(uri)
    record.errors.add(attribute, options[:url_not_accessible_message]   || :url_not_accessible)   unless response = url_works?(uri, options)
    record.errors.add(attribute, options[:url_invalid_response_message] || :url_invalid_response) unless check_valid_response?(response, options)
  end
  
  private
  
  def http_url_format_valid?(uri)
    uri.host.present? and not uri.path.nil?
  end
  
  def url_works?(uri, options)
    return true unless options[:check_host] or options[:check_path]
    
    check_host = options[:check_host]
    check_host ||= %w( http https ) if options[:check_path]
    if (schemes = Array.wrap(check_host)) and schemes.all? { |scheme| scheme.kind_of?(String) } then
      return true unless schemes.include?(uri.scheme)
    end
    
    case uri.scheme
      when 'http', 'https'
        return http_url_works?(uri, options)
      else
        return true
    end
  end

   def http_url_works?(uri, options)
     request = HTTPI::Request.new(uri.to_s)
     options[:request_callback].call(request) if options[:request_callback].respond_to?(:call)
     return HTTPI.get(request, options[:httpi_adapter])
     rescue
       return false
   end

  def check_valid_response?(response, options)
    return true unless response.kind_of?(HTTPI::Response) and options[:check_path]
    return false
  end

end
