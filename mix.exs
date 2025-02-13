defmodule FixpointSat.MixProject do
  use Mix.Project

  def project do
    [
      app: :fixpoint_sat,
      version: "0.1.4",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:fixpoint, ">= 0.10.0"},
      {:picosat_elixir, "~> 0.2.3", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:replbug, "~> 1.0.2", only: :dev}
    ]
  end

  defp description() do
    "SAT Solver"
  end

  defp docs() do
    [
      main: "readme",
      formatter_opts: [gfm: true],
      extras: [
        "README.md"
      ]
    ]
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "fixpoint_sat",
      # These are the default files included in the package
      files: ~w(lib test data .formatter.exs mix.exs README* LICENSE*
                ),
      exclude_patterns: ["misc/**", "scripts/**", "**/._exs"],
      licenses: licenses(),
      links: links(),
      description: description()
    ]
  end

  defp licenses() do
    ["MIT"]
  end

  defp links() do
    %{"GitHub" => "https://github.com/bokner/fixpoint_sat"}
  end

end
