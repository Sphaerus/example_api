class CreateJoinTableTargetGroupsCountries < ActiveRecord::Migration[5.2]
  def change
    create_join_table :target_groups, :countries do |t|
      # t.index [:target_group_id, :country_id]
      # t.index [:country_id, :target_group_id]
    end
  end
end
