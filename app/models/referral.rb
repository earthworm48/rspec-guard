class Referral < ActiveRecord::Base
	belongs_to :user

	def referrer
		self.user
	end
end