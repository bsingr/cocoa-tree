class CreateCocoaPods < ActiveRecord::Migration
  def change
    create_table :cocoa_pods do |t|
      t.string :name
      t.string :website_url
      t.string :doc_url
      t.string :source_url
      t.integer :stars
      t.datetime :pushed_at
      t.string :version

      t.timestamps
    end
  end
end
