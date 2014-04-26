class Media < Sequel::Model
  many_to_one :performance

  def validate
    validates_presence [:filename, :type]
  end
end
