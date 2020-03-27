# frozen_string_literal: true

module SolidusGraphqlApi
  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :payment_sources

    def initialize
      @payment_sources = ['SolidusGraphqlApi::Types::CreditCard']
    end
  end
end
