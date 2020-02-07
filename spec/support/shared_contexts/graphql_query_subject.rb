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

RSpec.shared_context "graphql mutation subject", type: :graphql_mutation do
  subject do |example|
    execute_mutation(
      try(:mutation) || example.metadata[:mutation],
      variables: try(:mutation_variables) || example.metadata[:mutation_variables],
      context: try(:mutation_context) || example.metadata[:mutation_context]
    )
  end
end
