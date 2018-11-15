require "spec"

require "../../src/monad/result"

Result = Monad::Result

describe Result do
  describe "::peek" do
    it "an Ok(E, T) returns a T" do
      Result.ok(10, Exception)
        .peek.should eq(10)
    end

    it "an Error(E, T) returns an E" do
      error = Exception.new("Boom")
      Result.error(error, String)
        .peek.should eq(error)
    end
  end

  describe "::fold" do
    it "Ok(E, T) calls ok receiver with a T" do
      double = ReceiverDouble(Exception, Int32).new

      Result.ok(10, Exception)
        .fold(double.error_receiver, double.ok_receiver)

      double.received.should eq(10)
    end

    it "Error(E, T) calls error receiver with an E" do
      error = Exception.new("Boom")
      double = ReceiverDouble(Exception, Int32).new

      Result.error(error, Int32)
        .fold(double.error_receiver, double.ok_receiver)

      double.received.should eq(error)
    end
  end

  describe "::map" do
    it "Ok(E, T) map T -> U = Ok(E, U)" do
      actual = Result
        .ok(10, Exception)
        .map(->(t : Int32){ t.to_s })

      actual.should be_a(Monad::Result(Exception, String))
      actual.peek.should eq("10")
    end

    it "Error(E, T) map T -> U = Error(E, U)" do
      error = Exception.new("Boom")

      actual = Result
        .error(error, Int32)
        .map(->(t : Int32){ t.to_s })
        
      actual.should be_a(Monad::Result(Exception, String))
      actual.peek.should eq(error)
    end
  end

  describe "::flat_map" do
    it "Ok(E, T) flat_map T -> Ok(E, U) = Ok(E, U)" do
      actual = Result
        .ok(10, Exception)
        .flat_map(->(t : Int32){ Result.ok(t.to_s, Exception) })

      actual.should be_a(Monad::Result(Exception, String))
      actual.peek.should eq("10")
    end

    it "Error(E, T) flat_map T -> Ok(E, U) = Error(E, U)" do
      error = Exception.new("Boom")

      actual = Result.error(error, Int32)
        .flat_map(->(t : Int32){ Result.ok(t.to_s, Exception) })

      actual.should be_a(Monad::Result(Exception, String))
      actual.peek.should eq(error)
    end

    it "Ok(E, T) flat_map T -> Ok(E, U) = Error(E, U)" do
      error = Exception.new("Boom")

      actual = Result.ok(10, Exception)
        .flat_map(->(t : Int32){ Result.error(error, String) })

      actual.should be_a(Monad::Result(Exception, String))
      actual.peek.should eq(error)
    end
  end
end

class ReceiverDouble(E, T)
  getter :received

  @received : Nil | E | T = nil

  def error_receiver
    ->(error : E) {
      @received = error
      nil
    }
  end

  def ok_receiver
    ->(ok : T) {
      @received = ok
      nil
    }
  end
end
