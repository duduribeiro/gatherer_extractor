class MagicSet
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  has n, :magic_cards
end
