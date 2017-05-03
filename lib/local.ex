defmodule Local do
  @moduledoc """
  """

  defmacro override(methods, from: a, with: b) do 
    quote do 
      import unquote(a), except: unquote(methods)
      import unquote(b), only: unquote(methods)
    end
  end

  defmacro scope(module_expr, do: expr) do 
    quote do 
      fn() ->
        unquote(module_expr)
        unquote(expr)
      end.()
    end
  end
  

end
