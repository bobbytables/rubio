require "rubio/version"
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/object'
require 'ap'

module Rubio
  class << self
    # Usage:
    #
    # Rubio.configure do |c|
    #   c.rdio_key 'CONSUMER_KEY'
    #   c.rdio_secret 'CONSUMER_SECRET'
    # end

    def configure(&block)
      Rubio::Configuration.configure(&block)
    end
  end

  autoload :Configuration, 'rubio/configuration'
  autoload :OAuth,         'rubio/oauth'
end

Rubio::Configuration.create_options