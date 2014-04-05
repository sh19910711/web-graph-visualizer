require "mongoid"

module Application
  module Models
    class GraphModel
      include Mongoid::Document
      embeds_one :input_text_model, autobuild: true
      embeds_one :parser_model, autobuild: true
    end
  end
end

