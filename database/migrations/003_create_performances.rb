Sequel.migration do
  change do
    create_table(:performances) do
      primary_key :id, index: true
      DateTime :last_seen, null: false
      Integer :times_tagged, null: false
      Float :location_latitude, null: false
      Float :location_longitude, null: false
      TrueClass :is_band, null: false 
      foreign_key :type_id, :types, null: false
    end
  end
end
