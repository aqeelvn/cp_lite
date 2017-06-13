class SignUp < Monban::Services::SignUp
  def perform
    super.tap do |user|
      send_welcome_mail(user)
    end
  end

  private

  def send_welcome_mail(user)
    UserMailer.welcome_email(user).deliver_later
  end
end
