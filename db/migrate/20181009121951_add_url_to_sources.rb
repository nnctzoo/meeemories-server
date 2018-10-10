class AddUrlToSources < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :url, :string, null: false
  end
end
