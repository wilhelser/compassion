module DonorClass

  #
  # Gets donor class for a specific donor
  # @param  email [String] donor's email address
  #
  # @return [String] donor class
  def get_donor_class(email)
    @email = email
    @total_contribution_amount = get_contributions(@email)
    return calculate_donor_class(@total_contribution_amount)
  end

  #
  # Get total contributions of a particular donor
  # @param  email [String] donor's email address
  #
  # @return [Decimal] donor's total contributions
  def get_contributions(email)
    @contributions = Contribution.where(:email => email)
    unless @contributions.nil?
      return @contributions.sum(:amount)
    else
      return 0.00
    end
  end

  #
  # Calculates donor class for a donor
  # @param  total_contribution_amount [Decimal] total contributions
  # amount for donor
  #
  # @return [String] donor class
  def calculate_donor_class(total_contribution_amount)
    case
    when total_contribution_amount.between?(100, 500)
      "1hand"
    when total_contribution_amount.between?(501, 1000)
      "2hands"
    when total_contribution_amount.between?(1001, 2000)
      "3hands"
    when total_contribution_amount.between?(2001, 50000)
      "4hands"
    when total_contribution_amount.between?(50001, 10000)
      "5hands"
    when total_contribution_amount.between?(10001, 20000)
      "6hands"
    when total_contribution_amount.between?(20001, 30000)
      "7hands"
    when total_contribution_amount.between?(30001, 50000)
      "8hands"
    when total_contribution_amount.between?(50001, 20000000)
      "9hands"
    else
      "nohands"
    end
  end
end
