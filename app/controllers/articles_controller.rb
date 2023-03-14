class ArticlesController < ApplicationController

  def index

    if params[:query].present?
      puts "################ #{params[:query.downcase].strip} #{User.find(current_user).id} #########"
      @articles = Article.where("LOWER(title) like  ?", "%#{params[:query.downcase].strip}%")
    else
      @articles = Article.all
    end
  end
end
