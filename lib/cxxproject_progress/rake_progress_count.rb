require 'rake'

module Rake
  class Task
    def progress_count
      @progress_count ||= 0
    end
    def progress_count=(v)
      @progress_count = v
    end
  end
end
