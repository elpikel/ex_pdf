defmodule ExPdf.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      ExPdf.PythonWorker
    ]

    opts = [strategy: :one_for_one, name: ExPdf.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
