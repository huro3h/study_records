class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, type: :bigint, foreign_key: { to_table: :users }, null: false, table_comment: 'ユーザのID'
      t.references :follower, type: :bigint, foreign_key: { to_table: :users }, null: false, table_comment: 'フォローしたユーザのID'

      t.timestamps
    end

    # 複合ユニークインデックス、ユーザとフォローするユーザの組み合わせで同じレコードが複数出来ないようにDBレベルで制限をかけます
    add_index :favorites, [:user_id, :follower_id], unique: :true
  end
end
