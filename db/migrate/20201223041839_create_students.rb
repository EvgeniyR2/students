class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'

    create_table :students, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_name
      t.string :gender, null: false
      t.string :identifier, index: { unique: true }
      t.references :user, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
