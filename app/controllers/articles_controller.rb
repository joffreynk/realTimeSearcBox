# frozen_string_literal: true
require 'net/http'
require 'socket'

class ArticlesController < ApplicationController
  def index
    
    ip_address = Socket.ip_address_list[1].ip_address
    @ip = ip_address
    if params[:query].present?
      createSearch(params[:query.downcase].strip)


      @articles = Article.where('LOWER(title) like  ?', "%#{params[:query.downcase].strip}%")
    else
      @articles = Article.all
    end
  end

  def createSearch(query)
    if Query.where(user_id: current_user.id).empty?
      Query.create(query:, user_id: current_user.id, times: 1)
    else
      lastquery = Query.where(user_id: current_user.id).order('updated_at DESC').first.query
      if lastquery.start_with?(query) && lastquery.length < query.length
        Query.find_by(query: lastquery, user_id: current_user.id).update(query:)
      else
        attempt = Query.find_by(query:, user_id: current_user.id)
        if !attempt.nil? && attempt.query.to_s == query
          attempt.update(times: attempt.times.to_i + 1)
        else
          Query.create(query:, user_id: current_user.id, times: 1)
        end
      end
    end
  end
end
