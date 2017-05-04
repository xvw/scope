defmodule Scope do
  @moduledoc """
  Scope is a small module that provides two macros to facilitate 
  function overload and local import/aliases execution.

  ## Overload functions

  ```
  import Scope 
  overload [+: 2, -: 2], from: Kernel, with: Test
  1 + 3 - 2 # gives [2, [1, 3]]
  ```

  ## Local importation

  You can just import one or more module :
  ```
  import Scope 
  x = local System do
    user_home <> " !"
  end

  # Or multiple module
  y = local Elixir.{System, Path} do 
    absname(user_home())
  end

  # Or specifics function from a module 
  z = local [user_home: 0, user_home!: 0] in System do 
    user_home <> " !"
  end
  ```

  You can also directly use an expression:
  ```
  import Scope 

  a = local (overload [+: 2, -: 2], from: Kernel, with: Test) do 
    1 + 2 - 3
  end

  b = 1 + 2 - 3 

  # a == [3, [1, 2]]
  # b == 0

  c = local (import Test) do 
    a = 1 + 2 
    b = 1 - 2 
    a - b 
  end
  ```

  """

  @doc false 
  def __using__(_opts) do 
    quote do: (import Scope)
  end

  @doc """
  Import module `from` except the gived functions and 
  import module `with` with only the gived functions.

  This is mainly useful for overloading operators used in `Kernel`.
  (Arithmetics operators for example)
  """
  defmacro overload(methods, from: a, with: b) do 
    quote do 
      import unquote(a), except: unquote(methods)
      import unquote(b), only: unquote(methods)
    end
  end


  @doc """
  Generate the execution of a lambda, with the importation 
  of the gived module expression.
  """
  defmacro local(module_expr, body)

  defmacro local({:in, _, [kw, module]}, do: expr) do 
    quote do 
      local(
        (import unquote(module), only: unquote(kw)),
        do: unquote(expr)
      ) 
    end
  end

  defmacro local({:__aliases__, _, [_]} = module, do: expr) do 
    quote do
      local(
        (import unquote(module)), 
        do: unquote(expr))
    end
  end

  defmacro local(module_expr, do: expr) do 
    quote do 
      fn() ->
        unquote(module_expr)
        unquote(expr)
      end.()
    end
  end
  

end
