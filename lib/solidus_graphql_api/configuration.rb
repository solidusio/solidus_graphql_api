# frozen_string_literal: true

module SolidusGraphqlApi
  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration; end
end
