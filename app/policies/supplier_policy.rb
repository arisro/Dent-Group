class SupplierPolicy
  attr_reader :user, :supplier

  def initialize(user, supplier)
    @user = user
    @supplier = supplier
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
