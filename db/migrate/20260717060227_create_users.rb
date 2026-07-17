class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.string :email
      t.string :password_digest
      t.string :role
      t.integer :mobile_num

      t.timestamps
    end
  end
end
