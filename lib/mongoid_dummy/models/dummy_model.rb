module MongoidDummy
  module Models
    class DummyModel
      include Mongoid::Document
      field :key_1, type: String
      field :key_2, type: String
    end
  end
end

