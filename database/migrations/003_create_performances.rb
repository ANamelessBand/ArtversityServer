Sequel.migration do
  change do
    create_table(:performances) do
      primary_key :id, index: true
      Date :last_date, null: false
      Integer :times_tagged, null: false
      Float :location_latitude, null: false
      Float :location_longitude, null: false
      foreign_key :type_id, :types, null: false
    end
  end
end
