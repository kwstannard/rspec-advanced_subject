#rspec-advanced_subject-0.0.1
advanced_subject attempts to cut out having to explicitly write the subject of your example group when trying to call methods or add arguments to methods. It works by reading the conventional description syntax to determine what the method you are calling is and later you state what you are passing to it.

Given you have a file advanced_subject_spec.rb.
```ruby
describe Hash do
  when_initialized_with [:a, :b] do
    it { should eq({a: :b}) }
  end
end
```

When you run `rspec -f d advanced_subject_spec.rb` it will output:
```
```

