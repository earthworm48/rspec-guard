class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.json :email
    end
  end
end
