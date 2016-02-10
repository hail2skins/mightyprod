class CreateCampaignVisits < ActiveRecord::Migration
  def change
    create_table :campaign_visits do |t|
      t.references :campaign, index: true, foreign_key: true
      t.references :visit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
