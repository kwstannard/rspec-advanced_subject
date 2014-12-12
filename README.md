#rspec-advanced_subject-0.0.4
advanced_subject attempts to cut out having to explicitly write the subject of your example group when trying to call methods or add arguments to methods. It works by reading the conventional description syntax to determine what the method you are calling is and later you state what you are passing to it.

Given you have a file advanced_subject_spec.rb.
```ruby
describe Hash do
  when_initialized_with [:a, :b] do
    it { should eq({a: :b}) }

    describe '#fetch' do
      when_passed :a do
        it { should eq(:b) }
      end
    end
  end
end
```

When you run `rspec -f d advanced_subject_spec.rb` it will output:
```
Hash
  when initialized with [:a, :b]
    should eq {:a => :b}
  #fetch
    when passed :a
      should eq :b
```

