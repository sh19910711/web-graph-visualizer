require "mongoid"

module Application
  module Models
    class InputTextModel
      include Mongoid::Document
      # Input Text
      field :text, type: String
    end
  end
end

