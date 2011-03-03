class AddIpAddressToSignUps < ActiveRecord::Migration
  def self.up
    add_column :sign_ups, :ip_address, :string
    add_column :sign_ups, :user_agent, :string
    add_column :sign_ups, :referer, :string
  end

  def self.down
    remove_column :sign_ups, :referer
    remove_column :sign_ups, :user_agent
    remove_column :sign_ups, :ip_address
  end
end
