class BetaRequestNotifier < ActionMailer::Base
  default from: "postmaster@compassionforhumanity.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.beta_request_notifier.new_request_notifier.subject
  #
  def new_request_notifier(request)
    @request = request
    mail(to: 'admin@compassionforhumanity.org', bcc: "wil@wilhelser.com", subject: "New Beta Request.")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.beta_request_notifier.invitation_notifier.subject
  #
  def invitation_notifier(request)
    @request = request
    mail(to: "#{@request.email}", bcc: "wil@wilhelser.com", subject: "Invitation to Compassion for Humanity.")
  end
end
