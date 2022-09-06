class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.integer :charge
      t.belongs_to :client 
      t.belongs_to :gym 
      t.timestamps
    end
  end
end
