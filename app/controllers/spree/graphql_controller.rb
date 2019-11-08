# frozen_string_literal: true

module Spree
  class GraphqlController < ApplicationController
    skip_before_action :verify_authenticity_token

    def execute
      render json: SolidusGraphqlApi::Schema.execute(
        params[:query],
        variables: ensure_hash(params[:variables]),
        context: { current_user: current_user },
        operation_name: params[:operationName]
      )
    rescue StandardError => e
      raise e unless Rails.env.development?

      handle_error_in_development e
    end

    private

    # Handle form data, JSON body, or a blank value
    def ensure_hash(ambiguous_param)
      case ambiguous_param
      when String
        if ambiguous_param.present?
          ensure_hash(JSON.parse(ambiguous_param))
        else
          {}
        end
      when Hash, ActionController::Parameters
        ambiguous_param
      when nil
        {}
      else
        raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
      end
    end

    def handle_error_in_development(error)
      logger.error error.message
      logger.error error.backtrace.join("\n")

      render json: { error: { message: error.message, backtrace: error.backtrace }, data: {} }, status: 500
    end

    def current_user
      @current_user ||= Spree.user_class.find_by(spree_api_key: bearer_token.to_s)
    end

    def bearer_token
      pattern = /^Bearer /
      header = request.headers["Authorization"]
      header.gsub(pattern, '') if header.present? && header.match(pattern)
    end
  end
end
