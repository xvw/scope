defmodule Scope do
  @moduledoc """
  Scope is a small module that provides two macros to facilitate 
  function overload and local import/aliases execution.
  """

  @doc false 
  def __using__(_opts) do 
    quote do: (import Scope)
  end

  @doc """
  """
  defmacro override(methods, from: a, with: b) do 
    quote do 
      import unquote(a), except: unquote(methods)
      import unquote(b), only: unquote(methods)
    end
  end


  @doc """
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
