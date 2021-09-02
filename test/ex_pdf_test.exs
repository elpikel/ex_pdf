defmodule ExPdfTest do
  use ExUnit.Case

  test "generates pdf" do
    pdf = ExPdf.generate()

    assert pdf != nil
  end
end
