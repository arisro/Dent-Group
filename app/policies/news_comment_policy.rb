class NewsCommentPolicy
  attr_reader :user, :news_comment

  def initialize(user, news_comment)
    @user = user
    @news_comment = news_comment
  end

  def destroy?
    user.admin? || news_comment.user == user
  end
end
