module Cxxproject
  class BuildingBlock
    typed_file_task_original = self.instance_method(:typed_file_task)

    define_method(:typed_file_task) do |type, hash, &block|
      t = typed_file_task_original.bind(self).call(type, hash) do |args|
        block.call(args)
      end
      t.progress_count = 1
      return t
    end
  end
end
