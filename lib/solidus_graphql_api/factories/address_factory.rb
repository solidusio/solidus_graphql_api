# frozen_string_literal: true

FactoryBot.modify do
  factory :address do
    firstname { 'John' }
    lastname { nil }
  end
end
