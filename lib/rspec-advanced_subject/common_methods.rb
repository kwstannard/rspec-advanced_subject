module RSpec::AdvancedSubject
  module CommonClassMethods
    def descriptee(m)
      m[:example_group][:description_args].first
    end
  end

  module RSpec::AdvancedSubject::CommonInstanceMethods

    def subject_args
      metadata.fetch(:with_args, Array.new)
    end

    def subject_class_proc
      metadata[:subject_class_proc]
    end

    def metadata
      self.class.metadata
    end
  end
end
