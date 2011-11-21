class Tutorial < ActiveRecord::Base
  belongs_to :user

  scope :preview_with_user, joins(:user).select("tutorials.*,users.username,users.id as user_id")
end
