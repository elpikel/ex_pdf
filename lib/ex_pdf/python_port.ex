defmodule ExPdf.PythonPort do
  @doc """
  ## Parameters
    - path: directory to include in python path (charlist)
  """
  def python_instance(path) when is_list(path) do
    python = System.get_env("PYTHON_BIN", "/usr/bin/python3") |> String.to_charlist

    {:ok, pid} = :python.start(python: python, python_path: path)

    pid
  end

  @doc """
  Call python function using MFA format
  """
  def call_python(pid, module, function, arguments \\ []) do
    :python.call(pid, module, function, arguments)
  end
end
