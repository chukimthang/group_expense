class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    else
      can :index, [Category, User]
      can :manage, [Product, GroupMember, Transaction]
    end
  end
end
