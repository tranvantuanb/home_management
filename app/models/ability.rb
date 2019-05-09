class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new

    case user.role
    when "admin"
      can :manage, :all if user.admin?
    when "member"
      can :manage, User do |u|
        user.id == u.id
      end
      can :read, [Cost, Room, RoomCost, UserCost]
    end
  end
end
