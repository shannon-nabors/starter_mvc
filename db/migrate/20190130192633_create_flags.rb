class CreateFlags < ActiveRecord::Migration[5.2]
  def change
    create_table :flags do |t|
      t.string :country
      t.string :adoption_date
      t.string :proportion
      t.text :design
    end
  end
end
