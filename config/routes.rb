# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/'
  end

  post '/', to: 'graphql#execute'
end
