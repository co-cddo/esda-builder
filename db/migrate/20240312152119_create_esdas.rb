class CreateEsdas < ActiveRecord::Migration[7.0]
  def change
    create_table :esdas, id: :uuid, default: "gen_random_uuid()" do |t|
      t.json :metadata

      t.timestamps
    end
  end
end
