ActiveAdmin.register Donation do
  index do
    column :amount do |donation|
      number_to_currency(donation.amount)
    end
    column :name
    column :created_at
    column :email
    actions
  end
end
