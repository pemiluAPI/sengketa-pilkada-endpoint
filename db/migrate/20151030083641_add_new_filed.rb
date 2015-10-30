class AddNewFiled < ActiveRecord::Migration
  def change
  	add_column :disputes, :upload_files, :string, after: :decision_verdict
  	add_column :disputes, :date, :datetime, after: :upload_files
  	add_column :disputes, :supporting_political_parties, :string, after: :date
  end
end
