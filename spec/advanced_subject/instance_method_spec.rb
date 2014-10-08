require 'rspec-advanced_subject'

class InstanceMock
  def single_argument(arg)
    arg
  end

  def multiple_arguments(*args)
    args
  end
end

describe InstanceMock do
  describe "#single_argument" do
    when_passed 5 do
      it { is_expected.to eq(5) }
    end

    when_passed 1 do
      it { is_expected.to eq(1) }
    end

    context "when explicitly setting subject" do
      subject { described_class.new.single_argument(5) }
      it { is_expected.to eq(5) }
    end

    context "when using default subject without passing arguments" do
      it "returns the default rspec subject" do
        expect(subject.single_argument(5)).to eq(5)
      end
    end
  end

  describe "#multiple_arguments" do
    when_passed do
      it { is_expected.to eq([]) }
    end

    when_passed 5, 5 do
      it { is_expected.to eq([5, 5]) }
    end

    when_passed *[1,2,3,4] do
      it { is_expected.to eq([1,2,3,4]) }
    end

    context "when explicitly setting subject" do
      subject { described_class.new.multiple_arguments(5) }
      it { is_expected.to eq([5]) }
    end
  end
end
