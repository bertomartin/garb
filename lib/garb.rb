require 'net/http'
require 'net/https'

require 'cgi'
require 'ostruct'
require 'crack'

begin
  require 'active_support/inflector'
  require 'active_support/deprecation'
rescue LoadError
  require 'active_support'
end

require 'garb/version'
require 'garb/request/authentication'
require 'garb/request/data'
# require 'garb/account_feed_request'
require 'garb/session'
require 'garb/profile_reports'
require 'garb/step'
require 'garb/destination'
require 'garb/filter_parameters'
require 'garb/report_parameter'
require 'garb/result_set'
require 'garb/report_response'
# require 'garb/resource'
# require 'garb/report'

require 'garb/model'

# management
require 'garb/management/feed'
require 'garb/management/segment'
require 'garb/management/account'
require 'garb/management/web_property'
require 'garb/management/profile'
require 'garb/management/goal'

require 'support'

module Garb
  GA = "http://schemas.google.com/analytics/2008"

  extend self

  class << self
    attr_accessor :proxy_address, :proxy_port, :proxy_user, :proxy_password
    attr_writer   :read_timeout
  end

  def read_timeout
    @read_timeout || 60
  end

  def to_google_analytics(thing)
    return thing.to_google_analytics if thing.respond_to?(:to_google_analytics)

    "ga:#{thing.to_s.camelize(:lower)}"
  end
  alias :to_ga :to_google_analytics

  def from_google_analytics(thing)
    thing.to_s.gsub(/^ga\:/, '').underscore
  end
  alias :from_ga :from_google_analytics

  def parse_properties(entry)
    Hash[entry['dxp:property'].map {|p| [Garb.from_ga(p['name']),p['value']]}]
  end

  def parse_link(entry, rel)
    entry['link'].detect {|link| link["rel"] == rel}['href']
  end

  # new(address, port = nil, p_addr = nil, p_port = nil, p_user = nil, p_pass = nil)

  # opts => open_timeout, read_timeout, ssl_timeout
  # probably just support open_timeout
end
