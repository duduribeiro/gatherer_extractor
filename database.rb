require 'data_mapper'
class Database
  def setup
    options = YAML.load_file("config/database.yml")
    DataMapper.setup(:default, options)
    DataMapper.finalize
    DataMapper.auto_migrate!
  end
end
