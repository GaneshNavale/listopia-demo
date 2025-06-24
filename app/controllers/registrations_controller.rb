# app/controllers/registrations_controller.rb
class RegistrationsController < ApplicationController
  before_action :redirect_if_authenticated

  # Show registration form
  def new
    @user = User.new
  end

  # Handle user registration
  def create
    @user = User.new(registration_params)

    if @user.save
      # Generate email verification token and send email
      token = @user.generate_email_verification_token
      AuthMailer.email_verification(@user, token).deliver_now

      # Check for pending collaboration invitation
      if session[:pending_collaboration_token]
        collaboration = ListCollaboration.find_by_invitation_token(session[:pending_collaboration_token])
        if collaboration && collaboration.email == @user.email
          collaboration.update!(user: @user, email: nil)
          session.delete(:pending_collaboration_token)
          flash[:notice] = "Account created and collaboration invitation accepted! Please verify your email to get started."
        end
      end

      redirect_to verify_email_path, notice: "Please check your email to verify your account."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Handle email verification
  def verify_email
    token = params[:token]
    user = User.find_by_email_verification_token(token)

    if user
      user.verify_email!
      sign_in(user)

      # If they just accepted a collaboration, redirect to the list
      if session[:pending_collaboration_token]
        collaboration = ListCollaboration.find_by_invitation_token(session[:pending_collaboration_token])
        if collaboration && collaboration.user == user
          session.delete(:pending_collaboration_token)
          redirect_to collaboration.list, notice: "Email verified! Welcome to the collaboration!"
          return
        end
      end

      redirect_to dashboard_path, notice: "Email verified! Welcome to Listopia!"
    else
      redirect_to root_path, alert: "Invalid or expired verification link."
    end
  end

  # Show email verification pending page
  def email_verification_pending
    # Just render the template
  end

  private

  # Strong parameters for user registration
  def registration_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Redirect authenticated users away from registration
  def redirect_if_authenticated
    redirect_to dashboard_path if current_user
  end
end
