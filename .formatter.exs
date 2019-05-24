[
  import_deps: [:commanded, :ecto, :phoenix],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: [project: 2, project: 3],
  subdirectories: ["priv/*/migrations"]
]
