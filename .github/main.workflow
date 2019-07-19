workflow "On Push" {
  on = "push"
  resolves = "Check GraphQL with Inspector"
}

# Deploy and Host GraphQL Inspector
action "Check GraphQL with Inspector" {
  uses = "kamilkisiela/graphql-inspector@master"
  secrets = ["GITHUB_TOKEN"]
}
