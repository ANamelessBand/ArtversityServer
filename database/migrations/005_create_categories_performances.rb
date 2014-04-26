Sequel.migration do
  change do
    create_table(:categories_performances) do
      primary_key :id, index: true
      foreign_key :category_id, :categories, null: false
      foreign_key :performance_id, :performances, null: false
    end
  end
end
