ActiveAdmin.register CapsTransaction do

  index do
    selectable_column
    column "Amount" do |transaction|
      "#{humanized_money transaction.caps} #{transaction.caps.currency.iso_code}"
    end
    column "Source" do |transaction|
      transaction.source.name
    end

    column "Destination" do |transaction|
      transaction.destination.name
    end

    column "Message", :message_from_source
    column "Date/Time", :created_at
  end

  filter :source, collection: User.all
  filter :destination, collection: User.all
  filter :created_at
end
