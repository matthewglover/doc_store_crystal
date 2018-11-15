module Monad
  abstract class Maybe(T)
    def self.just(value : T)
      Just(T).new(value)
    end

    def self.nothing(type : T.class)
      Nothing(T).new
    end

    abstract def peek : T?

    abstract def map(proc : Proc(T, U)) : Maybe(U) forall U
    
    abstract def flat_map(proc : Proc(T, Maybe(U))) : Maybe(U) forall U
    
    abstract def apply(maybe_value : Maybe(U)) : Maybe(U) forall U
  end

  private class Just(T) < Maybe(T)
    def initialize(@value : T)
    end

    def peek
      @value
    end

    def map(proc : Proc(T, U)) forall U
      Maybe(U).just(proc.call(@value))
    end

    def flat_map(proc : Proc(T, Maybe(U))) forall U
      proc.call(@value)
    end

    def apply(maybe_value : Maybe(U)) forall U
      maybe_value.map(@value)
    end
  end

  private class Nothing(T) < Maybe(T)
    def peek
      nil
    end
  
    def map(proc : Proc(T, U)) : Maybe(U) forall U
      Maybe.nothing(U)
    end

    def flat_map(proc : Proc(T, Maybe(U))) forall U
      Maybe.nothing(U)
    end

    def apply(maybe_value : Maybe(U)) forall U
      puts T.class
      Maybe.nothing(U)
    end
  end
end
