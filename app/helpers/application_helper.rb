module ApplicationHelper

  def set_active? action_name, controller_name=nil
    if controller_name
      controller.controller_name == controller_name && controller.action_name == action_name ? "active" : ""
    else
      controller.action_name == action_name ? "active" : ""
    end
  end

  def is_owner? obj, user
    user && obj && obj.user && obj.user == user
  end

  def display_date(input_date)
    return input_date.strftime("%d %B %Y")
  end

  def display_date_short(input_date)
    input_date.strftime("%d/%b/%Y")
  end

  def tutorial_slug tutorial=nil, options = {}
    if tutorial && tutorial.slug
      "/" + tutorial.slug
    elsif tutorial && tutorial.title
      "/" + Tutorial.get_slug(tutorial)
    else
      tutorial_path tutorial, options
    end
  end

  def auth_url(provider)
    "/auth/open_id#{{:openid_url=>provider}.to_query_string}"
  end

  def auth_link provider
    link_to provider, auth_url(provider)
  end

end
