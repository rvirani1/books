class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :identities
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  has_many :created_books, :class_name => 'Book', :foreign_key => 'created_by'
  has_many :reviews
  has_many :reviewed_books, through: :reviews, :source => :book, :primary_key => "book_id"


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
    target_ids = Friend.where(source_id: id).pluck :target_id
    User.find target_ids
  end

  def received_recommendations
    Recommendation.where(recipient: self)
  end

  def friend! other
    Friend.where(source_id: id, target_id: other.id).first_or_create!
  end

  def unfriend! other
    Friend.where(source_id: id, target_id: other.id).delete_all
  end

  # This is the reverse of the friends relation; see
  # the comment above
  def messagable_friends
    source_ids = Friend.where(target_id: id).pluck :source_id
    User.find source_ids
  end

  def reviewed_book?(book)
    self.reviewed_books.include?(book)
  end
end
