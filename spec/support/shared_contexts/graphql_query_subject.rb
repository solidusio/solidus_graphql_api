# frozen_string_literal: true

RSpec.shared_context "graphql query subject", type: :graphql_query do
  subject do |example|
    execute_query(
      try(:query) || example.metadata[:query],
      variables: try(:query_variables) || example.metadata[:query_variables],
      context: try(:query_context) || example.metadata[:query_context]
    )
  end
end
