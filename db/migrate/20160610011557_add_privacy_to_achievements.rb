class AddPrivacyToAchievements < ActiveRecord::Migration[5.0]
  def change
    add_column :achievements, :privacy, :integer
  end
end
