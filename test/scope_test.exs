defmodule ScopeTest do
  use ExUnit.Case
  doctest Scope

  defmodule Test do 
    def a + b, do: [a, b]
    def a - b, do: [b, a]
    def hello, do: "Hello World !"
  end

  test "simple overloading" do 
    import Scope 
    assert 2 == (1 + 3 - 2)
    overload [+: 2, -: 2], from: Kernel, with: Test
    assert [2, [1, 3]] == (1 + 3 - 2)
  end

  test "simple scoped importation" do 
    import Scope 
    x = local System, do: user_home() <> " !"
    assert x == (System.user_home() <> " !")
  end

  test "restricted scoped importation" do 
    import Scope 
    x = local [hello: 0] in Test do 
      hello() <> "!!"
    end
    assert x == "Hello World !!!"
  end
  
  
  

end
