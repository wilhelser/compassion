class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, :to => :crud
    can :manage, Project, :user_id => user.id
  end

  def initialize(contractor)
    contractor ||= Contractor.new
    alias_action :create, :read, :update, :destroy, :to => :crud
    can :manage, Gallery, :contractor_id => contractor.id
    can :manage, ContractorSelection, :contractor_id => contractor.id
  end
end
