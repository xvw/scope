defmodule Local.Mixfile do
  use Mix.Project

  def project do
    [
      app: :scope,
      version: "1.0.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ],
      source_url: "https://github.com/xvw/scope",
      homepage_url: "https://github.com/xvw/scope",
      package: package(),
      description: description()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end

  defp description do 
    """
    Scope is a small module that provides two macros to facilitate 
    function overload and local import/aliases execution.
    """
  end

  defp package do
    [
     name: :scope,
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Xavier Van de Woestyne"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/xvw/scope",
              "Docs" => "http://hexdoc.pm/scope"}]
end
end
