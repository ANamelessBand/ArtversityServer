Sequel.migration do
  change do
    create_table(:attachments) do
      primary_key :id, index: true
      String :filename, size: 32, unique: true, null: false
      foreign_key :performance_id, :performances, null: false
    end
  end
end
