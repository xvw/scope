# Scope

Scope is a small module that provides two macros to facilitate 
function overload and local import/aliases execution.

## Overload functions

```elixir
import Scope 
overload [+: 2, -: 2], from: Kernel, with: Test
1 + 3 - 2 # gives [2, [1, 3]]
```

## Local importation

You can just import one or more module :

```elixir
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

```elixir
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


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `scope` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:scope, "~> 1.0.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/local](https://hexdocs.pm/scope).

