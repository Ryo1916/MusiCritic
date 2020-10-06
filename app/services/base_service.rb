# frozen_string_literal: true

class BaseService
  def initialize
    raise NotImplementedError
  end

  def run!
    raise NotImplementedError
  end
end
