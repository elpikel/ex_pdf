defmodule ExPdf do
  alias ExPdf.PythonWorker

  def generate do
    get_data()
    |> populate_html()
    |> generate_pdf()
  end

  defp get_data do
    %{
      customer: %{address: "2382 Feathers Hooves Drive", full_name: "Corey G Miller"},
      order_items: [
        %{name: "bought item 1", quantity: "22", price: "10000.00"},
        %{name: "bought item 2", quantity: "2", price: "400.00"},
        %{name: "bought item 3", quantity: "2200", price: "500.99"},
        %{name: "bought item 4", quantity: "10", price: "500.55"},
        %{name: "bought item 5", quantity: "1", price: "700.10"},
        %{name: "bought item 6", quantity: "1", price: "10.20"}
      ]
    }
  end

  defp populate_html(%{customer: customer, order_items: order_items}) do
    EEx.eval_file(
      Path.join([:code.priv_dir(:ex_pdf), "templates", "invoice.html"]),
      customer: customer,
      order_items: order_items
    )
  end

  defp generate_pdf(html) do
    PythonWorker.generate(html)
  end
end
