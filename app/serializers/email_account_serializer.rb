  class EmailAccountSerializer
    include FastJsonapi::ObjectSerializer

    attributes *[
      :first_name,
      :last_name,
      :user_name,
      :country_code,
      :phone_number,
      :email,
      :activated,
      :uid,
      :user_type
    ]
  end
