class Type < Sequel::Model
  one_to_many :performances
  one_to_many :categories

  def validate
    validates_presence [:name]
    validates_unique(:name)
  end
end
