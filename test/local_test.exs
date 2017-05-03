defmodule LocalTest do
  use ExUnit.Case
  doctest Local


  defmodule Test do 

    def a + b do
      [a, b] 
    end

    def a - b do 
      [b, a]
    end
    
    

  end
  

  test "the truth" do


    import Local

    scope (override [+: 2, -: 2], from: Kernel, with: Test) do 
      IO.inspect 1+1
    end

    scope (import System) do 
      IO.inspect user_home()
    end
    


    assert 1 + 1 == 2
  end
end
