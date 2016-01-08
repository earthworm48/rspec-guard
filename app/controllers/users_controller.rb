class UsersController < ApplicationController

	def new
		user_id = cookies.signed["user_id"] 

		unless User.find_by(id: user_id).nil?
			user = User.find(user_id)
			redirect_to action: :referrals
		else
			cookies.delete :user_id# redirect_to referrals_path
		end

		if params[:ref_code]
			user = User.find_by(referral_code: params[:ref_code])
			cookies.signed[:ref_code] = user.referral_code
		end
		
	end

	def create
		# can't store data in cookies!
		# session[:ref_code] = @user.referral_code
		ref_code = cookies.signed["ref_code"] 
		# byebug
		if ref_code.nil?
			@user = User.new(email: params[:user][:email])
			@user.save!
			cookies.signed[:ref_code] = @user.referral_code
			# byebug
			# cookies.save!
			# cookies.permanent[:user_id] = {value: @user.id, expires: 100.years.from_now}
		else
			user = User.find_by(referral_code: ref_code)
			# byebug
			referral = user.referrals.new(email: params[:user][:email])
			# byebug
			referral.save!
			@user = user
			
		end
		cookies.permanent.signed[:user_id] = @user.id
		
# byebug
		redirect_to referrals_path
	end

	def referrals
		render 'new'
	end

	def refer
		# user = User.find(cookies.signed["user_id"])
		# byebug
		if cookies.signed["user_id"] 
			user = User.find(cookies.signed["user_id"])
			@referral_code = user.referral_code
			redirect_to user
		else
			# byebug
			redirect_to root_path
		end

	end

	# private

	# def user_params
	# 	params.require(:user).permit(:email)
	# end
end