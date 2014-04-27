Sequel.migration do
  change do
    alter_table(:attachments) do
      add_column :type, String, null: false
    end
  end
end
