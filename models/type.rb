class Type < Sequel::Model
  one_to_many :performances
  one_to_many :categories

  def validate
    validates_presence [:name]
    validates_unique(:name)
  end

  def categories_data
    {categories: categories.map(&:values)}
  end

  def full_data
    values.merge categories_data
  end

  def self.all_data
    map &:full_data
  end
end
