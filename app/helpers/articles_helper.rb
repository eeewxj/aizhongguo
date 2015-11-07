module ArticlesHelper
  def can_like_article(current_user_id, article_id)
    !!ArticleLike.find_by_article_id_and_user_id(article_id, current_user_id).nil?
  end

  def can_collect_article(current_user_id, article_id)
    !!Collection.find_by_article_id_and_user_id(article_id, current_user_id).nil?
  end

end
