class RSpec::Core::ExampleGroup
  def self.when_passed(*args, &example_group_block)
    ::RSpec::AdvancedSubject::Core.when_passed(*args, self, &example_group_block)
  end

  def self.when_initialized_with(*args, &example_group_block)
    ::RSpec::AdvancedSubject::Core.when_initialized_with(*args, self, &example_group_block)
  end

  define_example_group_method :describe, advanced_subject: true
end

module RSpec::AdvancedSubject::Core
  def self.when_passed(*args, example_groups, &example_group_block)
    example_groups.context(method_describe_string(*args), with_args: args, &example_group_block)
  end

  def self.when_initialized_with(*args, example_groups, &example_group_block)
    example_groups.context(initialization_describe_string(*args), initialization_args: args, &example_group_block)
  end

  private

  def self.method_describe_string(*args)
    "when passed #{argument_joiner(args)}"
  end

  def self.initialization_describe_string(*args)
    "when passed #{argument_joiner(args)}"
  end

  def self.argument_joiner(args)
    if args.empty?
      "nothing"
    else
      args.map(&:inspect).join(", ")
    end
  end
end
