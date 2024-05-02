class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :bookmarks
  has_many :categories
  has_one_attached :icon

  validates :email, # rubocop:disable Rails/UniqueValidationWithoutIndex
    presence: { if: :devise_will_save_change_to_email? },
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
    length: { within: 8..30, if: :password_required? }
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

  protected

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    true
  end
end
