# frozen_string_literal: true
require 'socket'

class ArticlesController < ApplicationController
  def index
    
    if params[:query].present?
      createSearch(params[:query.downcase].strip)


      @articles = Article.where('LOWER(title) like  ?', "%#{params[:query.downcase].strip}%")
    else
      @articles = Article.all
    end
  end

  def createSearch(query)
    address = Socket.ip_address_list[1].ip_address
    
    if Query.where(userip: address).empty?
      Query.create(query:, userip: address, times: 1)
    else
      lastquery = Query.where(userip: address).order('updated_at DESC').first.query
      if query.start_with?(lastquery)
        if lastquery.length < query.length
          Query.find_by(query: lastquery, userip: address).update(query:)
        end
      else
        attempt = Query.find_by(query:, userip: address)
        if !attempt.nil? && attempt.query.to_s == query
          attempt.update(times: attempt.times.to_i + 1)
        else
          Query.create(query:, userip: address, times: 1)
        end
      end
    end
  end
end
