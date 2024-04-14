class AccountSerializer < BaseSerializer
  attributes *[
    :activated,
    :country_code,
    :email,
    :first_name,
    :middle_name,
    :full_phone_number,
    :last_name,
    :phone_number,
    :type,
    :user_type,
    :created_at,
    :updated_at,
    :device_id,
    :unique_auth_id,
    :city,
    :country,
    :background,
    :day,
    :month,
    :year,
    :uid
  ]

  attributes :image do |object|
    Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) if object.image.attached?
  end

  attributes :banner do |object|
    Rails.application.routes.url_helpers.rails_blob_path(object.banner, only_path: true) if object.banner.attached?
  end

  attribute :country_code do |object|
    country_code_for(object)
  end

  attribute :phone_number do |object|
    phone_number_for(object)
  end

  class << self
    private

    def country_code_for(object)
      return nil unless Phonelib.valid?(object.full_phone_number)
      Phonelib.parse(object.full_phone_number).country_code
    end

    def phone_number_for(object)
      return nil unless Phonelib.valid?(object.full_phone_number)
      Phonelib.parse(object.full_phone_number).raw_national
    end
  end
end
