class MagicCard
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :multiverse_id, Integer
  property :link, Text
  belongs_to :magic_set

  validates_presence_of :name
  validates_presence_of :link
  validates_presence_of :multiverse_id

  def ==(other)
    self.class == other.class && self.name == other.name
  end
end
