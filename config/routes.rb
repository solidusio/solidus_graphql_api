# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  post '/', to: 'graphql#execute'
end
