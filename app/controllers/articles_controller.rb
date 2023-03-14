class ArticlesController < ApplicationController

  def index
    if params[:query].present?
      @players = Article.where("LOWER(title) like  ?", "%#{params[:query.downcase]}%")
    else
      @players = Article.all
    end
  end
end
