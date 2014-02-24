require 'spec_helper'

describe Application::Module01 do
  before do
    @module = Application::Module01.new
  end

  context :get do
    it :get_one do
      expect(@module.get_one()).to equal 1
    end
    it :get_two do
      expect(@module.get_two()).to equal 2
    end
    it :get_three do
      expect(@module.get_three()).to equal 3
    end
  end
end
