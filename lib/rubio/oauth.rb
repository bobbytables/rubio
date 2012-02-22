require 'oauth'
require 'httparty'

module Rubio
  class OAuth
    API_URL = 'http://api.rdio.com'

    class << self
      def consumer
        @consumer ||= ::OAuth::Consumer.new(Configuration.rdio_key , Configuration.rdio_secret, {
          :site               => API_URL,
          :request_token_path => "/oauth/request_token",
          :authorize_path     => "/oauth/authorize",
          :access_token_path  => "/oauth/access_token"
        })
      end

      def request_token
        @request_token ||= self.consumer.get_request_token
      end

      def access_token_no_auth
        @access_token ||= ::OAuth::AccessToken.new consumer
      end

      def access_token_auth_url
        'https://www.rdio.com/oauth/authorize?oauth_token=' + self.request_token.token.to_s
      end

      def access_token
        @access_token || access_token_no_auth
      end

      def authorized?(value=nil)
        return @authorized if value.nil?
        @authorized = !!value
      end
    end
  end
end