class Category < Sequel::Model
  many_to_one :type
  many_to_many :performances

  def validate
    validates_presence [:name]
    validates_unique(:name)
  end
end
