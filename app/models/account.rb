class Account < ApplicationRecord
  self.table_name = :accounts

  include Wisper::Publisher
  
  validates :email, presence: true
  validates :password, presence: true

  # has_secure_password
  # before_validation :parse_full_phone_number
  # has_one_attached :image, dependent: :destroy
  # has_one_attached :banner, dependent: :destroy

  has_one :feedback, class_name: 'Feedback', dependent: :destroy
  accepts_nested_attributes_for :feedback, allow_destroy: true
  # validate :validate_user_name_for_email_account
  before_create :generate_uid

  # has_many :add_ideas, class_name: "Settings::AddIdea", dependent: :destroy

  enum status: %i[regular suspended deleted]
  enum user_type: %i[ideator visitor]

  scope :active, -> { where(activated: true) }
  scope :existing_accounts, -> { where(status: ['regular', 'suspended']) }

  def generate_uid
    self.uid  = rand(1_00000..9_99999)
  end


  def self.ransackable_attributes(auth_object = nil)
    ["activated", "age", "app_language_id", "background", "city", "country", "country_code", "created_at", "date_of_birth", "day", "device_id", "email", "first_name", "full_name", "full_phone_number", "gender", "id", "id_value", "is_blacklisted", "is_paid", "last_name", "last_visit_at", "middle_name", "month", "password", "phone_number", "platform", "role_id", "status", "stripe_id", "stripe_subscription_date", "stripe_subscription_id", "suspend_until", "type", "uid", "unique_auth_id", "updated_at", "user_name", "user_type", "year"]
  end



  private

  # def encode(id)
  #   # byebug
  #   JsonWebToken.encode id
  # end
  
  def user_name_unique?
    # Check if user_name is unique among SocialAccounts only
    !self.class.where.not(id: self.id).where(user_name: user_name).exists?
  end

  def valid_email
    unless email =~ URI::MailTo::EMAIL_REGEXP
      errors.add(:email, "Invalid email format")
    end
  end

  def parse_full_phone_number
    phone = Phonelib.parse(full_phone_number)
    self.full_phone_number = phone.sanitized
    self.country_code      = phone.country_code
    self.phone_number      = phone.raw_national
  end

  def valid_phone_number
    unless Phonelib.valid?(full_phone_number)
      errors.add(:full_phone_number, "Invalid or Unrecognized Phone Number")
    end
  end
end
