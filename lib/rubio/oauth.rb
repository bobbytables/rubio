# encoding: UTF-8

require 'httparty'
require 'securerandom'
require 'base64'
require 'openssl'
require 'oauth'

module Rubio
  class OAuth
    API_URL = 'http://api.rdio.com/1/'

    attr_accessor :access_token, :access_token_secret

    def call(method, params)
      @method = method
      @params = params

      query = {:method => @method}.merge(@params).to_query

      access_token.post("/1/#{method}", query, {'Content-Type' => 'application/x-www-form-urlencoded' })
    end

    def params(params={})
      @params = params
    end

    def method(name)
      @method = name
    end

    def consumer
      @consumer ||= ::OAuth::Consumer.new(Rubio::Configuration.rdio_key, Rubio::Configuration.rdio_secret, {        
        :site   => 'http://api.rdio.com',        
        :scheme => :header        
      })
    end

    def access_token
      @access_token ||= ::OAuth::AccessToken.new(consumer)
    end
  end
end