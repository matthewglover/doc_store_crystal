module Monad
  abstract class Result(E, T)
    def self.ok(ok_value : T, error_type : E)
      Ok.new(ok_value, error_type)
    end

    def self.error(error_value : E, ok_type : T)
      Error.new(error_value, ok_type)
    end

    abstract def peek : E | T

    abstract def fold(error_receiver : Proc(E, Nil), ok_receiver : Proc(T, Nil)) : Nil

    abstract def map(proc : Proc(T, U)) forall U

    abstract def flat_map(proc : Proc(T, Result(E, U))) forall U
  end

  private class Ok(E, T) < Result(E, T)
    def initialize(@ok_value : T, @error_type : E.class)
    end

    def peek : E | T
      @ok_value
    end

    def fold(error_receiver : Proc(E, Nil), ok_receiver : Proc(T, Nil)) : Nil
      ok_receiver.call(@ok_value)
      nil
    end

    def map(proc : Proc(T, U)) forall U
      Result.ok(proc.call(@ok_value), E)
    end

    def flat_map(proc : Proc(T, Result(E, U))) forall U
      proc.call(@ok_value)
    end
  end

  private class Error(E, T) < Result(E, T)
    def initialize(@error_value : E, @ok_type : T.class)
    end

    def peek : E | T
      @error_value
    end

    def fold(error_receiver : Proc(E, Nil), ok_receiver : Proc(T, Nil)) : Nil
      error_receiver.call(@error_value)
      nil
    end

    def map(proc : Proc(T, U)) forall U
      Result.error(@error_value, U)
    end

    def flat_map(proc : Proc(T, Result(E, U))) forall U
      Result.error(@error_value, U)
    end
  end
end
