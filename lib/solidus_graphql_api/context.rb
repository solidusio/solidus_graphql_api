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
      { current_user: current_user,
        current_ability: current_ability,
        current_store: current_store,
        order_token: order_token }
    end

    def current_user
      @current_user ||= Spree.user_class.find_by(spree_api_key: bearer_token)
    end

    def current_ability
      @current_ability ||= Spree::Ability.new(current_user)
    end

    def order_token
      @order_token ||= headers["X-Spree-Order-Token"]
    end

    def current_store
      @current_store ||= Spree::Config.current_store_selector_class.new(request).store
    end

    def current_order
      return @current_order if instance_variable_defined?(:@current_order)

      @current_order = current_order_by_current_user || current_order_by_guest_token
    end

    private

    def bearer_token
      @bearer_token ||= headers[AUTHORIZATION_HEADER].to_s.match(TOKEN_PATTERN) do |match_data|
        match_data[:token]
      end
    end

    def current_order_by_current_user
      current_user&.last_incomplete_spree_order(store: current_store)
    end

    def current_order_by_guest_token
      incomplete_orders = Spree::Order.incomplete
      incomplete_orders = incomplete_orders.where(store: current_store) if current_store

      incomplete_orders.find_by(guest_token: order_token)
    end
  end
end
