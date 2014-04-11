require "mongoid"

module Application
  module Models
    class InputTextModel
      include Mongoid::Document
      # Input Text
      field :text, type: String
      belongs_to :graph_model
    end
  end
end

