module Application
  module Models
    class InputTextModel
      include Mongoid::Document
      # Input Text
      field :text, type: string
    end
  end
end

