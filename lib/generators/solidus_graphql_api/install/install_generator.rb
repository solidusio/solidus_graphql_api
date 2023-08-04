# frozen_string_literal: true

module SolidusGraphqlApi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false
      source_root File.expand_path('templates', __dir__)
      argument :app_path, type: :string, default: Rails.root

      MOUNT_GRAPHQL_ENGINE = "mount SolidusGraphqlApi::Engine, at: '/graphql'"

      def copy_initializer
        template 'initializer.rb', 'config/initializers/solidus_graphql_api.rb'
      end

      def add_migrations
        run 'bin/rails railties:install:migrations FROM=solidus_graphql_api'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask('Would you like to run the migrations now? [Y/n]')) # rubocop:disable Layout/LineLength
        if run_migrations
          run 'bin/rails db:migrate'
        else
          puts 'Skipping bin/rails db:migrate, don\'t forget to run it!' # rubocop:disable Rails/Output
        end
      end

      def install_routes
        if Pathname(app_path).join('config', 'routes.rb').read.include? MOUNT_GRAPHQL_ENGINE
          say_status :route_exist, MOUNT_GRAPHQL_ENGINE, :blue
        else
          route <<~RUBY
            # This line installs graphql's main route to execute queries

            mount SolidusGraphqlApi::Engine, at: '/graphql'
          RUBY
        end
      end
    end
  end
end
