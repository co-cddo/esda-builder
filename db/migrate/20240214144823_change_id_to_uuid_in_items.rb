class ChangeIdToUuidInItems < ActiveRecord::Migration[7.0]
  def up
    enable_extension "pgcrypto"

    add_column :items, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :items do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    execute "ALTER TABLE items ADD PRIMARY KEY (id);"
  end

  def down
    add_column :items, :integer_id, :integer

    Item.all.each_with_index { |item, index| item.update!(integer_id: (index + 1)) }

    change_table :items do |t|
      t.remove :id
      t.rename :integer_id, :id
    end

    execute "ALTER TABLE items ADD PRIMARY KEY (id);"
  end
end
