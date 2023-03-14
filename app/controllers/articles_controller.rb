class ArticlesController < ApplicationController

  def index
    if params[:query].present?
      createSearch(params[:query.downcase].strip)
      puts "################ #{params[:query.downcase].strip} #{current_user.id} #########"
      @articles = Article.where("LOWER(title) like  ?", "%#{params[:query.downcase].strip}%")
    else
      @articles = Article.all
    end
  end

  def createSearch(query)
    
  end


end
