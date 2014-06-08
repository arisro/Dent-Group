class StatusCommentPolicy
  attr_reader :user, :status_comment

  def initialize(user, status_comment)
    @user = user
    @status_comment = status_comment
  end

  def destroy?
    user.admin? || status_comment.status.user == user || status_comment.user == user
  end
end
