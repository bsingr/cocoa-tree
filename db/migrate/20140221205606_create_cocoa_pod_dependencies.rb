class CreateCocoaPodDependencies < ActiveRecord::Migration
  def change
    create_table :cocoa_pod_dependencies do |t|
      t.references :cocoa_pod, index: true
      t.references :dependent_cocoa_pod, index: true

      t.timestamps
    end
  end
end
