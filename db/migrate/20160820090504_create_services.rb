class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.text :description
      t.date :notification_date
      t.string :frequency
      t.string :mobile_number
      t.text :custom_message
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
