class ProductVivieuPolicy < Struct.new(:user, :product_vivieu)
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
    user.try(:admin) || product_vivieu.reviewer_id == user.id || user.try(:manager)
  end

  def show?
    product_vivieu.publish? || user.try(:admin) || product_vivieu.reviewer_id == user.id || user.try(:manager)
  end

  def destroy?
    user.try(:admin) || product_vivieu.reviewer_id == user.id
  end
end