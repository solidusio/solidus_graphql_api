# frozen_string_literal: true

module SolidusGraphqlApi
  class Context
    AUTHORIZATION_HEADER = "Authorization"
    TOKEN_PATTERN = /^Bearer (?<token>.*)/.freeze

    attr_reader :request, :headers

    def initialize(request:)
      @request = request
      @headers = request.headers
    end

    def to_h
      { current_user: current_user }
    end

    def current_user
      @current_user ||= Spree.user_class.find_by(spree_api_key: bearer_token)
    end

    private

    def bearer_token
      @bearer_token ||= headers[AUTHORIZATION_HEADER].to_s.match(TOKEN_PATTERN) do |match_data|
        match_data[:token]
      end
    end
  end
end
