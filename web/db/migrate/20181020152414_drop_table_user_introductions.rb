class DropTableUserIntroductions < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_introductions
  end
end
