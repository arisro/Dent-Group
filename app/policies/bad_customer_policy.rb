class BadCustomerPolicy
  attr_reader :user, :customer

  def initialize(user, customer)
    @user = user
    @customer = customer
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    user.admin? || user == customer.user
  end

  def update?
    user.admin? || user == customer.user
  end

  def destroy?
    user.admin? || user == customer.user
  end
end
