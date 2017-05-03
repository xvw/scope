defmodule ScopeTest do
  use ExUnit.Case
  doctest Scope

  import Scope

  test "duh" do 
    local [user_home: 0] in System, do: IO.inspect user_home()
    local System, do: IO.inspect user_home()
    local (import System), do: IO.inspect user_home()
    
  end
  

end
