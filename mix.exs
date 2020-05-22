defmodule ExAwsTranscribe.MixProject do
  use Mix.Project

  @version "0.2.4"

  def project do
    [
      app: :ex_aws_transcribe,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      description: "AWS Transcribe service module for ex_aws",
      source_url: "https://github.com/brianlow/ex_aws_transcribe",
      homepage_url: "https://github.com/brianlow/ex_aws_transcribe",
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    []
  end

  defp package do
    [
      licenses: ["mit"],
      links: %{"GitHub" => "https://github.com/brianlow/ex_aws_transcribe"}
    ]
  end

  defp docs() do
    [
      main: "readme",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/ex_aws_transcribe",
      extras: [
        "README.md": [title: "Overview"]
      ]
    ]
  end

  defp deps do
    [
      {:ex_aws, "~> 2.1.1"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:hackney, ">= 0.0.0", only: [:dev, :test]},
      {:poison, ">= 0.0.0", only: [:dev, :test]},
      {:sweet_xml, ">= 0.0.0", only: [:dev, :test]},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false},
    ]
  end
end
