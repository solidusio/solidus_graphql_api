# frozen_string_literal: true

SolidusGraphqlApi::Engine.routes.draw do
  post '/', to: 'graphql#execute'
end