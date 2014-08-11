class MagicCard
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  belongs_to :magic_set

  def ==(other)
    self.class == other.class && self.name == other.name
  end
end
