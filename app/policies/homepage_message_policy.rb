class HomepageMessagePolicy
  attr_reader :user, :message

  def initialize(user, message)
    @user = user
    @message = message
  end

  def index?
    user.admin?
  end

  def new?
    user.admin?
  end

  def show?
    true
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
