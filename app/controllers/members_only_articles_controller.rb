class MembersOnlyArticlesController < ApplicationController
  before_action :authenticate_user

  def index
    articles = Article.where(is_member_only: true)
    render json: articles
  end

  def show
    article = Article.find(params[:id])
    if article.is_member_only?
      render json: article
    else
      render_unauthorized
    end
  end

  private

  def authenticate_user
    unless logged_in?
      render_unauthorized
    end
  end

  def render_unauthorized
    render json: { error: 'Unauthorized access' }, status: :unauthorized
  end



end
