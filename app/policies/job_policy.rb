class JobPolicy
  attr_reader :user, :job

  def initialize(user, job)
    @user = user
    @job = job
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    user.admin? || user == job.user
  end

  def update?
    user.admin? || user == job.user
  end

  def destroy?
    user.admin? || user == job.user
  end
end
