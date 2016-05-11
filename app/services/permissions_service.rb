class PermissionsService
  def initialize(user, controller, action)
    @_user = user
    @_controller = controller
    @_action = action
  end
  
  private

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
