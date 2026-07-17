class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.string :email
      t.string :password_digest
      t.integer :role, default:0
      t.integer :contact
      t.string :generate_token
      t.boolean :email_varified

      t.timestamps
    end
  end
end
