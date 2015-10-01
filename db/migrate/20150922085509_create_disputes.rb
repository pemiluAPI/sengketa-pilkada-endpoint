class CreateDisputes < ActiveRecord::Migration
  def change
    create_table :disputes do |t|
    	t.integer :region_id
    	t.integer :category_id
    	t.string :applicant
    	t.string :respondent
    	t.text :disputed
    	t.string :decision_verdict

      t.timestamps
    end
  end
end
