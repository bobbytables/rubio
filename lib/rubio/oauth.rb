# encoding: UTF-8

require 'httparty'
require 'securerandom'
require 'base64'
require 'openssl'

module Rubio
  class OAuth
    API_URL = 'http://api.rdio.com/1/'

    attr_accessor :access_token, :access_token_secret

    def call(method, params)
      @method = method
      @params = params

      response = HTTParty.post(API_URL, :body => {:method => @method}.merge(@params), :headers => headers)
      response
    end

    def body
      URI.escape(@params.collect{|k,v| "#{k}=#{v}"}.join('&'))
    end

    def headers
      {'authorization' => authorization_header}
    end

    def authorization(values={})
      values[:oauth_consumer_key] ||= Configuration.rdio_key

      # Uniqueness identifiers
      values[:oauth_nonce]            = SecureRandom.hex(8)
      values[:oauth_signature_method] = 'HMAC-SHA1'
      values[:oauth_timestamp]        = Time.now.to_i.to_s

      values[:oauth_version] = '1.0'

      values
    end

    def authorization_header
      values = authorization
      ap [hmac_key, hmac_body]
      values[:oauth_signature] = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA1.new, hmac_key, hmac_body)).strip
      
      'OAuth ' + values.collect {|key,value| "#{key}=\"#{value}\"" }.join(', ')
    end

    private

    def percent_escape(value)
      value.bytes.map do |b|
        c = b.chr
        if ((c >= '0' and c <= '9') or
            (c >= 'A' and c <= 'Z') or
            (c >= 'a' and c <= 'z') or
            c == '-' or c == '.' or c == '_' or c == '~')
          c
        else
          '%%%02X' % b
        end
      end.join
    end

    def hmac_key
      parts = [Configuration.rdio_secret, self.access_token_secret]
      parts.join('&')
    end

    def hmac_body
      # method, url, body (params)
      parts = ['POST', API_URL].map {|p| percent_escape(p) }
      parts << percent_escape({:method => @method}.merge(@params).merge(authorization).to_param)
      parts.join('&')
    end
  end
end