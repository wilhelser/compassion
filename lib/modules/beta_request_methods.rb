module BetaRequestMethods
  def subscribe_user_to_mailchimp(request)
    @request = request
    @first_name = @request.name.split(' ')[0]
    @last_name = @request.name.split(' ')[1] ||= ''
    gb = Gibbon::API.new
    gb.lists.subscribe({:id => '2f91b1c3eb', :email => {:email => @request.email}, :merge_vars => {:FNAME => @first_name, :LNAME => @last_name}, :double_optin => false})
  end
end
