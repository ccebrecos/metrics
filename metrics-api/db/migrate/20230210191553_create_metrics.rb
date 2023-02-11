class CreateMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :metrics, id: :uuid do |t|
      t.string :name, null: false
      t.float :value, null: false
      t.timestamp :valid_at, null: false

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end

  add_index :metrics, %i[name valid_at], unique: true
end
