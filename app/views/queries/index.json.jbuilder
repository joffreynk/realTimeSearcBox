# frozen_string_literal: true

json.array! @quesries, partial: 'queries/query', as: :query
