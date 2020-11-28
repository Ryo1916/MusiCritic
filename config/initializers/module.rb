# frozen_string_literal: true

class Module
  # Add `privates` method to Module class.
  def privates(&block)
    target = self
    Module.new do
      refine target do
        class_eval(&block)
      end
    end
  end
end
