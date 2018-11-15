require "spec"

require "../../src/monad/maybe"

Maybe = Monad::Maybe

describe Maybe do
  int_to_string = ->(x : Int32) { x.to_s }
  int_to_just_of_string = ->(x : Int32) { Maybe.just(x.to_s) }
  int_to_nothing_of_string = ->(x : Int32) { Maybe.nothing(String) }

  describe "::peek" do
    it "a Just(T) contains T" do
      Maybe.just(10)
        .peek.should eq(10)
    end
  

    it "a Nothing(T) contains Nil" do
      Maybe.nothing(Int32)
        .peek.should be nil
    end
  end

  describe "::map" do
    it "Just(T) map T -> = Just(U)" do
      actual = Maybe
        .just(10)
        .map(int_to_string)
      
      actual.should be_a(Monad::Maybe(String))
      actual.peek.should eq "10"
    end

    it "Nothing(T) map T -> U = Nothing(U)" do
      actual = Maybe
        .nothing(Int32)
        .map(int_to_string)

      actual.should be_a(Monad::Maybe(String))
      actual.peek.should be nil
    end
  end

  describe "::flat_map" do
    it "Just(T) flat_map T -> Just(U) = Just(U)" do
      actual = Maybe.just(10)
        .flat_map(int_to_just_of_string)

      actual.should be_a(Monad::Maybe(String))
      actual.peek.should eq "10"
    end

    it "Just(T) flat_map T -> Nothing(U) = Nothing(U)" do
      actual = Maybe.just(10)
        .flat_map(int_to_nothing_of_string)
      
      actual.should be_a(Monad::Maybe(String))
      actual.peek.should be_nil
    end

    it "Nothing(T) flat_map T -> Just(U) = Nothing(T)" do
      actual = Maybe.nothing(Int32)
        .flat_map(int_to_just_of_string)

      actual.should be_a(Monad::Maybe(String))
      actual.peek.should eq nil
    end
  end

  describe "::apply" do
    it "Just(Proc(T, U)) apply Just(T) = Just(U)" do
      actual = Maybe.just(int_to_string)
        .apply(Maybe.just(10))

      actual.should be_a(Monad::Maybe(String))
      actual.peek.should eq("10")
    end

    it "Nothing(Proc(T, U)) apply Just(T) = Nothing(U)" do
      actual = Maybe.nothing(Proc(Int32, String))
        .apply(Maybe.just(10))

      actual.should be_a(Monad::Maybe(String))
      actual.peek.should be_nil
    end

    it "given a type Nothing(T), a Just(T -> U) returns a Nothing(U)" do
      Maybe.just(int_to_string)
        .apply(Maybe.nothing(Int32))
        .peek.should be_nil
    end
  end
end
