class AddCommentsFieldToCommunityOfferDetails < ActiveRecord::Migration
  def change
    add_column :community_offer_details, :question_or_comment, :text
  end
end
