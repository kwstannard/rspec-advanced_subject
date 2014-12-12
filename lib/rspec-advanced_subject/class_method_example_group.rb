module RSpec::AdvancedSubject::ClassMethodExampleGroup
  extend RSpec::AdvancedSubject::CommonClassMethods
  include RSpec::AdvancedSubject::CommonInstanceMethods
  RSpec.configure do |c|
    c.include self, {advanced_subject:
      lambda do |a, m|
      descriptee(m).to_s.match(class_regex)
      end
    }
  end

  def self.included(base)
    set_subject_proc(base.metadata)
    set_subject_method_name(base.metadata)

    base.subject do
      raise NotImplementedError if metadata[:with_args].nil?
      instance_eval &subject_proc
    end
  end

  def self.set_subject_proc(metadata)
    metadata[:subject_proc] = proc do |x|
      described_class.send(
        subject_method_name,
        *subject_args
      )
    end
  end

  def self.set_subject_method_name(metadata)
    d = metadata[:description_args].first
    metadata[:subject_method_name] = d.gsub class_regex, ""
  end

  def self.class_regex
    /^\./
  end

  def subject_proc
    metadata[:subject_proc]
  end

  def subject_method_name
    metadata[:subject_method_name]
  end
end
