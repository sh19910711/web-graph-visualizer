require "mongoid"

module Application
  module Models
    class ParserModel
      include Mongoid::Document
      # パーサーの種類 
      field :type, type: String
      # パーサーのオプションの値
      field :options, type: Array
      belongs_to :graph_model
    end
  end
end

