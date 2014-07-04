require 'rspec-advanced_subject'

class ClassMock
  def self.single_argument(arg)
    arg
  end

  def self.multiple_arguments(*args)
    args
  end
end

describe ClassMock do
  describe ".single_argument" do
    when_passed 5 do
      it { should eq(5) }
    end

    when_passed 1 do
      it { should eq(1) }
    end

    context "when explicitly setting subject" do
      subject { described_class.single_argument(5) }
      it { should eq(5) }
    end

    context "when using default subject without passing arguments" do
      it "raises NotImplementedError" do
        expect{subject.single_argument(5)}.to raise_error(NotImplementedError)
      end
    end
  end

  describe ".multiple_arguments" do
    when_passed do
      it { should eq([]) }
    end

    when_passed 5, 5 do
      it { should eq([5, 5]) }
    end

    when_passed *[1,2,3,4] do
      it { should eq([1,2,3,4]) }
    end

    context "when explicitly setting subject" do
      subject { described_class.multiple_arguments(5) }
      it { should eq([5]) }
    end
  end
end
