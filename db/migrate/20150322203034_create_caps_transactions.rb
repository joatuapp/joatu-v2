require 'money-rails'
class CreateCapsTransactions < ActiveRecord::Migration
  def change
    create_table :caps_transactions do |t|
      t.references :source, polymorphic: true, index: true, required: true
      t.references :destination, polymorphic: true, index: true, required: true
      t.monetize :caps
      t.text :message_from_source
    end
  end
end
