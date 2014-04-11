require "mongoid"

module Application
  module Models
    class GraphModel
      include Mongoid::Document
      has_one(
        :input_text_model,
        {
          autobuild: true,
          autosave: true,
        },
      )
      has_one(
        :parser_model,
        {
          autobuild: true,
          autosave: true,
        },
      )
    end
  end
end

