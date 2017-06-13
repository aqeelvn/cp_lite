class SignUp < Monban::Services::SignUp
  def perform
    super.tap do |user|
      if user.valid?
        send_welcome_mail(user)
        create_access_token(user)
      end
    end
  end

  private

  def send_welcome_mail(user)
    UserMailer.welcome_email(user).deliver_later
  end

  def create_access_token(user)
    user.access_tokens.create
  end
end
