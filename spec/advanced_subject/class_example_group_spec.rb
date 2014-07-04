require 'rspec-advanced_subject'

class Comparator
  def ==(other)
    other.instance_variables == self.instance_variables
  end
end

class NoArgs < Comparator; end

describe NoArgs do
  when_initialized_with do
    it { should eq(NoArgs.new) }
  end
end

class InitializationMock < Comparator
  def initialize(foo); @foo = foo; end
end

describe InitializationMock do
  when_initialized_with 5 do
    it { should eq(InitializationMock.new(5)) }
  end
end

class MultiArgsInitializationMock < Comparator
  def initialize(*args); @foo,@bar = *args; end
end

describe MultiArgsInitializationMock do
  when_initialized_with do
    it { should eq(MultiArgsInitializationMock.new) }
  end

  when_initialized_with 5, 10 do
    it { should eq(MultiArgsInitializationMock.new(5, 10)) }
  end
end

class InitializeAndMethodCall
  def initialize(foo); @foo = foo; end

  def instance_method(arg)
    [@foo, arg]
  end
end

describe InitializeAndMethodCall do
  when_initialized_with 5 do
    describe "#instance_method" do
      when_passed 10 do
        it { should eq([5,10]) }
      end
    end
  end
end
