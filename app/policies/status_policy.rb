class StatusPolicy
  attr_reader :user, :status

  def initialize(user, status)
    @user = user
    @status = status
  end

  def destroy?
    user.admin? || status.user == user
  end
end
