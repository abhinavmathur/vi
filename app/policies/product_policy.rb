class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.try(:admin) || user.try(:manager)
    end
  end

  def create?
    user.try(:reviewer) || user.try(:admin)
  end

  def update?
    user.try(:reviewer) || user.try(:admin) || user.try(:manager)
  end

  def destroy?
    user.try(:admin)
  end

end
