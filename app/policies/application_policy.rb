class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.is_admin? || false
  end

  def show?
    true
  end

  def create?
    user.is_admin? || false
  end

  def new?
    create?
  end

  def update?
    user.is_admin? || false
  end

  def edit?
    update?
  end

  def destroy?
    user.is_admin? || false
  end

  def scope
    Pundit.policy_scope!(user, record.model.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end

    private

    def require_logged_in_user!
      if !user.present? || user.guest?
        raise UnauthorizedError
      end
    end
  end

  private

  def require_logged_in_user!
    unless user.present? && !user.guest?
      raise UnauthorizedError
    end
  end
end

