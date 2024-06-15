class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :bookmarks
  has_many :categories
  has_one_attached :icon
  accepts_nested_attributes_for :icon_attachment, allow_destroy: true

  validates :email, # rubocop:disable Rails/UniqueValidationWithoutIndex
    presence: { if: :email_required? },
    uniqueness: { scope: :is_deleted, if: -> { is_deleted == false } },
    format: {
      with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/,
      case_sensitive: true,
      if: :devise_will_save_change_to_email?,
      allow_blank: true,
    }
  validates :password,
    presence: { if: :password_required? },
    confirmation: { if: :password_required? },
    length: { within: 8..30, if: :password_required?, allow_blank: true }
  validates :name, presence: true
  validates :profile, length: { maximum: 300 }

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.find_for_authentication(tainted_conditions)
    conditions = devise_parameter_filter.filter(tainted_conditions)
    conditions[:is_deleted] = false
    to_adapter.find_first(conditions)
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    true
  end
end
