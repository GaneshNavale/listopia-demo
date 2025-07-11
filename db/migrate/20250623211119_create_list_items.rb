# db/migrate/20250623211119_create_list_items.rb
class CreateListItems < ActiveRecord::Migration[8.0]
  def change
    create_table :list_items, id: :uuid do |t|
      t.references :list, null: false, foreign_key: true, type: :uuid, index: true
      t.references :assigned_user, foreign_key: { to_table: :users }, type: :uuid, index: true

      t.string :title, null: false
      t.text :description
      t.integer :item_type, default: 0, null: false
      t.integer :priority, default: 1, null: false

      # Completion tracking
      t.boolean :completed, default: false
      t.datetime :completed_at

      # Scheduling
      t.datetime :due_date
      t.datetime :reminder_at

      # Ordering
      t.integer :position, default: 0

      # Additional data
      t.string :url # for link type items
      t.json :metadata, default: {}

      t.timestamps
    end

    # Only add indexes that aren't automatically created by t.references
    add_index :list_items, :item_type
    add_index :list_items, :priority
    add_index :list_items, :completed
    add_index :list_items, :due_date
    add_index :list_items, :position
    add_index :list_items, :created_at
  end
end
