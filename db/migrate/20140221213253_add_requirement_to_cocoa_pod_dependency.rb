class AddRequirementToCocoaPodDependency < ActiveRecord::Migration
  def change
    add_column :cocoa_pod_dependencies, :requirement, :string
  end
end
