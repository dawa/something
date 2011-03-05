class AddNotifiedToSignUps < ActiveRecord::Migration
  def self.up
    add_column :sign_ups, :notified, :interger
  end

  def self.down
    remove_column :sign_ups, :notified
  end
end
