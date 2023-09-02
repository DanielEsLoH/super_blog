class AddCascadeToDeleteToComments < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key :comments, :posts # Elimina la clave externa existente
    add_foreign_key :comments, :posts, on_delete: :cascade # Agrega una nueva clave externa con cascada
  end

  def down
    remove_foreign_key :comments, :posts
    add_foreign_key :comments, :posts
  end
end
