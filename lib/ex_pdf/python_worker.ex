defmodule ExPdf.PythonWorker do
  use GenServer

  alias ExPdf.PythonPort

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    path = Path.join([:code.priv_dir(:ex_pdf), "python"])
    pid = PythonPort.python_instance(to_charlist(path))

    {:ok, %{python_pid: pid}}
  end

  def terminate(_reason, %{python_pid: pid}) do
    :python.stop(pid)
  end

  def generate(html) do
    GenServer.call(__MODULE__, %{html: html})
  end

  def handle_call(%{html: html}, _from, %{python_pid: pid} = state) do
    pdf = PythonPort.call_python(pid, :pdf, :generate, [html])

    {:reply, pdf, state}
  end
end
