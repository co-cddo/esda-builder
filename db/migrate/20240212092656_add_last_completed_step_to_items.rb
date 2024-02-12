class AddLastCompletedStepToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :last_completed_step, :string
  end
end
