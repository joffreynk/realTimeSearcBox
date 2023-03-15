# frozen_string_literal: true

json.extract! query, :id, :query, :times, :created_at, :updated_at
json.url queries_url(queries, format: :json)
