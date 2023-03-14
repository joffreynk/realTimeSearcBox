class ArticlesController < ApplicationController

  def index
    if params[:query].present?
      @articles = Article.where("LOWER(title) like  ?", "%#{params[:query.downcase]}%")
    else
      @articles = Article.all
    end
  end
end
