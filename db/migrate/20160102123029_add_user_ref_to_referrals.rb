class AddUserRefToReferrals < ActiveRecord::Migration
  def change
    add_reference :referrals, :user, index: true, foreign_key: true
  end
end
