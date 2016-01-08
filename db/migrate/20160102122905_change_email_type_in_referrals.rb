class ChangeEmailTypeInReferrals < ActiveRecord::Migration
   def up
    change_column :referrals, :email, :string
  end

  def down
    change_column :referrals, :email, :json
  end
end
