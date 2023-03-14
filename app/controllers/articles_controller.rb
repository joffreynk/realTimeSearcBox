class ArticlesController < ApplicationController

  def index
    if params[:query].present?
      createSearch(params[:query.downcase].strip)
      @articles = Article.where("LOWER(title) like  ?", "%#{params[:query.downcase].strip}%")
    else
      @articles = Article.all
    end
  end

  def createSearch(query)
    if Query.all.length < 1
       Query.create(query: query, user_id: current_user.id, times: 1)
    else
      lastquery = Query.order("created_at DESC").first.query
      if lastquery.include?(query) || query.include?(lastquery)
        if(lastquery.length < query.length)
           Query.find_by(query:lastquery,user_id: current_user.id).update(query: query)
        end
      else
        attempt = Query.find_by(query: query, user_id: current_user.id)
        if attempt
          attempt.update(times: attempt.times.to_i+1)
        else
          Query.create(query: query, user_id: current_user.id, times: 1)
        end
      end
    end



    
  end


end
