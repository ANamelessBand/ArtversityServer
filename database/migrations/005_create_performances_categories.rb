Sequel.migration do
  change do
    create_table(:medias) do
      primary_key :id, index: true
      foreign_key :performance_id, :performances, null: false
      foreign_key :category_id, :categories, null: false
    end
  end
end
