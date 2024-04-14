ActiveAdmin.register Account do

  # actions :all, except: [:new]
  actions :all

  permit_params :uid, :first_name, :last_name, :user_name,:email


    index :title=> "User" do
      selectable_column
      id_column
      column :first_name
      column :last_name
      column :email
      column :user_name
      column :uid
      actions
    end

    filter :first_name, as: :string, label: "First Name"
    filter :last_name, as: :string, label: "Last Name"
    filter :email
    filter :user_name, as: :string, label: "User Name"
    filter :uid, as: :string, label: "UID"

    show do
      attributes_table title: "User Details" do
        row :first_name
        row :last_name
        row :email
        row :user_name
        row :uid
        row :password_digest
        row :created_at
        row :updated_at
      end
    end

    form do |f|
      f.inputs do
        f.input :first_name
        f.input :last_name
        f.input :email
      end
      f.actions
    end
  
end
