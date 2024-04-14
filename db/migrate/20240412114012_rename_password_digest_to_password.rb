class RenamePasswordDigestToPassword < ActiveRecord::Migration[7.1]
  def change
    rename_column :accounts, :password_digest, :password
  end
end
