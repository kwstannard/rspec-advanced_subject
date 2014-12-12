module RSpec::AdvancedSubject::InstanceMethodExampleGroup
  extend RSpec::AdvancedSubject::CommonClassMethods
  include RSpec::AdvancedSubject::CommonInstanceMethods

  RSpec.configure do |c|
    c.include self, {advanced_subject:
      ->(a,m) do
      descriptee(m).to_s.match(instance_regex)
      end
    }
  end

  def self.included(base)
    set_subject_method_proc(base.metadata)
    set_subject_method_name(base.metadata)

    base.subject do
      if metadata[:with_args].nil?
        super()
      else
        callee
      end
    end
  end

  def self.set_subject_method_proc(metadata)
    metadata[:subject_method_proc] = Proc.new do |x|
      x.send(
        subject_method_name, *subject_args
      )
    end
  end

  def self.set_subject_method_name(metadata)
    d = metadata[:description_args].first
    metadata[:subject_method_name] = d.gsub instance_regex, ""
  end

  def self.instance_regex
    /^#/
  end

  def callee
    instance_exec parent_callee, &subject_method_proc
  end

  def parent_callee
    instance_eval &subject_class_proc
  end

  def subject_method_proc
    metadata[:subject_method_proc]
  end

  def subject_method_name
    metadata[:subject_method_name]
  end
end
