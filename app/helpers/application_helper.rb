module ApplicationHelper
  def title
    @title
  end

  def set_active? action_name, controller_name=nil
    if controller_name
      controller.controller_name == controller_name && controller.action_name == action_name ? "active" : ""
    else
      controller.action_name == action_name ? "active" : ""
    end
  end
end
