class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :async

  has_attached_file :avatar, :styles => {
      :thumb    => ['100x100#',  :jpg, :quality => 70],
      :preview  => ['480x480#',  :jpg, :quality => 70],
      :large    => ['600>',      :jpg, :quality => 70],
      :retina   => ['1200>',     :jpg, :quality => 30]
    },
    :convert_options => {
      :thumb    => '-set colorspace sRGB -strip',
      :preview  => '-set colorspace sRGB -strip',
      :large    => '-set colorspace sRGB -strip',
      :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
    }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :friendships, foreign_key: "source_id"
  has_many :friends, through: :friendships, source: :target
  has_many :identities
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  has_many :created_books, :class_name => 'Book', :foreign_key => 'created_by'
  has_many :reviews
  has_many :reviewed_books, through: :reviews, :source => :book, :primary_key => "book_id"


  def requests
    targeted_by = User.joins(:friendships).where(friendships: {target_id: self.id })
    targets = self.friends

    (targeted_by - targets)
  end

  def self.create_from_omniauth(params)
    attributes = {
      email: params['info']['email'],
      password: Devise.friendly_token
    }

    create(attributes)
  end

  #Code for working single provider Omniauth

  #def self.from_omniauth(auth)
  #  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #    user[:provider] = auth.provider
  #    user[:uid] = auth.uid
  #    user[:email] = auth.info.email
  #    user.save!
  #  end
  #end

  #def self.new_with_session(params, session)
  #  if session["devise.user_attributes"]
  #    new(session["devise.user_attributes"], without_protection: true) do |user|
  #      user.attributes = params
  #      user.valid?
  #    end
  #  else
  #    super
  #  end
  #end

  def friends
    target_ids = Friendship.where(source_id: id).pluck :target_id
    User.find target_ids
  end

  def received_recommendations
    Recommendation.where(recipient: self)
  end

  def friend! other
    Friendship.where(source_id: id, target_id: other.id).first_or_create!
  end

  def unfriend! other
    Friendship.where(source_id: id, target_id: other.id).delete_all
  end

  # This is the reverse of the friends relation; see
  # the comment above
  def messagable_friends
    source_ids = Friendship.where(target_id: id).pluck :source_id
    User.find source_ids
  end

  def reviewed_book?(book)
    self.reviewed_books.include?(book)
  end
end
