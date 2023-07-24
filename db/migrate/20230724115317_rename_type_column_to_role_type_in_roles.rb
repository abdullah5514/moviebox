class RenameTypeColumnToRoleTypeInRoles < ActiveRecord::Migration[7.0]
  def change
    rename_column :roles, :type, :role_type
  end
end
