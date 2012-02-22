require "rubio/version"
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/class/attribute'

module Rubio
  class << self
    def configure(&block)
      Rubio::Configuration.configure(&block)
    end
  end

  autoload :Configuration, 'rubio/configuration'
end

Rubio::Configuration.create_options