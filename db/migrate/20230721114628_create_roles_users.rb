class CreateRolesUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :roles_users, id: false do |t|
      t.belongs_to :role
      t.belongs_to :user
    end

    add_index :roles_users, [:role_id, :user_id], unique: true
  end
end
