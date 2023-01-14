class CreateStudyRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :study_records do |t|
      t.datetime :study_date, null:false
      t.integer :study_time, null:false
      t.references :user, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end