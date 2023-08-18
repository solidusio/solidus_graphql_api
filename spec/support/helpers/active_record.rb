# frozen_string_literal: true

module Helpers
  module ActiveRecord
    def run_migrations(&block)
      migration = Class.new(::ActiveRecord::Migration[6.1]).tap do |klass|
        klass.define_method(:up, &block)
      end
      ::ActiveRecord::Migration.suppress_messages { migration.migrate(:up) }
    end

    def create_model(name, &block)
      stub_const(name, Class.new(ApplicationRecord)).tap do |klass|
        klass.class_eval(&block) if block_given?
      end
    end
  end
end
