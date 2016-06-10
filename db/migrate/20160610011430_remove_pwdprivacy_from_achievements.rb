class RemovePwdprivacyFromAchievements < ActiveRecord::Migration[5.0]
  def change
    remove_column :achievements, :pwdprivacy, :integer
  end
end
