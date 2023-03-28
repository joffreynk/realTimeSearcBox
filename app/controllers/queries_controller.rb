# frozen_string_literal: true

require 'socket'

class QueriesController < ApplicationController
  def index
    address = Socket.ip_address_list[1].ip_address
    @queries = Query.where(userip: address).order('times DESC')
  end
end
