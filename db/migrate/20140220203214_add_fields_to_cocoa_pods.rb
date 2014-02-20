class AddFieldsToCocoaPods < ActiveRecord::Migration
  def change
    add_column :cocoa_pods, :summary, :string
    add_column :cocoa_pods, :category, :string
    add_column :cocoa_pods, :wiki_url, :string
  end
end
