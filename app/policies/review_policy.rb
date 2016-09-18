class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.try(:admin) || user.try(:manager)
      scope.where(publish: true)
    end
  end

  def create?
    user.try(:admin) || user.try(:reviewer)
  end

  def update?
    user.try(:admin) || record.reviewer_id == user.id || user.try(:manager)
  end

  def show?
    record.publish? || user.try(:admin) || record.author == user || user.try(:manager)
  end

  def destroy?
    user.try(:admin) || record.reviewer_id == user.id
  end
end
