class NewsPolicy
  attr_reader :user, :news

  def initialize(user, news)
    @user = user
    @news = news
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
