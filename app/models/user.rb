class User < ActiveRecord::Base
	default_scope  { order(:id => :desc) }
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
	validates :email, uniqueness: true
	validates :referral_code, uniqueness: true
	before_create :generate_referral_code
	has_many :referrals
	# byebug
	# private
	def generate_referral_code
		self.referral_code = SecureRandom.hex		
	end

	def add_referral(hash)
		# byebug
		self.referrals.create(hash)
	end
end