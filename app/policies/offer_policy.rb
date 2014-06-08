class OfferPolicy
  attr_reader :user, :offer

  def initialize(user, offer)
    @user = user
    @offer = offer
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    user.admin? || offer.user == user
  end

  def update?
    user.admin? || offer.user == user
  end

  def destroy?
    user.admin? || offer.user == user
  end
end
