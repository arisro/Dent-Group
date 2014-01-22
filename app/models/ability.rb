class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    can :access, :rails_admin
    can :dashboard
    can :manage, :all

    if user.is? :visitor

    end

    if user.is? :user

    end

    if user.is? :moderator

    end

    if user.is? :admin

    end
  end
end
