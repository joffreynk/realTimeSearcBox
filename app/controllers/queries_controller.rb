# frozen_string_literal: true

class QueriesController < ApplicationController
  def index
    @queries = Query.where(user_id: current_user.id)
  end
end
