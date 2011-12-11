class Tutorial < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  validates_uniqueness_of :slug
  validates_presence_of :title
  before_validation :create_slug

  scope :preview_with_user, joins(:user).select("tutorials.*,users.username,users.id as user_id")

  private
  def create_slug
    if created_at && title
      self.slug = "#{created_at.year}/#{created_at.month}/#{title.parameterize}"
    end
  end

end
