class CreateTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :terms do |t|
      t.datetime :start_term
      t.datetime :end_term

      t.timestamps
    end
  end
end
