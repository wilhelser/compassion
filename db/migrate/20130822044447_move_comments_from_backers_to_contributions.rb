class MoveCommentsFromBackersToContributions < ActiveRecord::Migration
  def change
    remove_column :backers, :comments
    add_column :contributions, :comments, :text
  end
end
