# frozen_string_literal: true

json.extract! atricle, :id, :title, :body, :created_at, :updated_at
json.url atricles_url(atricles, format: :json)
