class Tutorial < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  acts_as_taggable
  validates_uniqueness_of :slug
  validates_presence_of :title, :on => :update
  before_validation :create_slug

  scope :preview_with_user, joins(:user).select("tutorials.*,users.username,users.id as user_id")

  def self.get_slug tutorial
     "#{tutorial.created_at.year}/#{tutorial.created_at.month}/#{tutorial.title.parameterize}"
  end

  def self.get_or_create_slug tutorial
    tutorial.slug ? tutorial.slug : get_slug(tutorial)
  end

  def self.published
    where(:draft => false)
  end

  private
  def create_slug
    if !slug && created_at && title
      self.slug = self.class.get_slug self
    end
  end

end
