class PermissionsService
  extend Forwardable

  def_delegators :user,
                 :platform_admin?,
                 :store_admin?,
                 :registered_user?

  def initialize(user, controller, action)
    @_user = user || User.new
    @_controller = controller
    @_action = action
  end

  def allow?
    case
    when platform_admin? then platform_admin_permissions
    when store_admin? then store_admin_permissions
    when registered_user? then registered_user_permissions
    else
      guest_permissions
    end
  end

  private

    def platform_admin_permissions
      return true if controller == "sessions"
      return true if controller == "stores" && action.in?(%w(index show))
      return true if controller == "items" && action.in?(%w(index show))
      return true if controller == "orders" && action.in?(%w(index show))
      return true if controller == "users" && action.in?(%w(index show))
    end

    def store_admin_permissions
      return true if controller == "sessions"
      return true if controller == "stores" && action.in?(%w(index show))
      return true if controller == "items" && action.in?(%w(index show))
      return true if controller == "orders" && action.in?(%w(index show))
    end

    def registered_user_permissions
      return true if controller == "sessions"
      return true if controller == "stores" && action.in?(%w(index show))
      return true if controller == "items" && action.in?(%w(index show))
    end

    def guest_permissions
      return true if controller == "stores" && action == "index"
      return true if controller == "sessions" && action == "new"
      return true if controller == "sessions" && action == "create"
      return true if controller == "sessions" && action == "destroy"
    end

    def controller
      @_controller
    end

    def action
      @_action
    end

    def user
      @_user
    end

end
