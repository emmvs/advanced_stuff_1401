class CreateSellers < ActiveRecord::Migration[7.0]
  def change
    create_table :sellers do |t|
      t.string :csv_id
      t.string :zip_code_prefix
      t.string :city
      t.string :state
      t.string :name

      t.timestamps
    end

    add_index :sellers, :csv_id, unique: true
  end
end
