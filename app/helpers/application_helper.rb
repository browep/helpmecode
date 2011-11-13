module ApplicationHelper
  def title
    @title
  end

  def set_active? class_name
    Rails.logger.debug "controller_name: "  + class_name + " " + controller.action_name
    controller.action_name == class_name ? "action" : ""
  end
end
