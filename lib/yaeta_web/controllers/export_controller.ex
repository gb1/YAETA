defmodule YaetaWeb.ExportController do
  use YaetaWeb, :controller

  def export(conn, _params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"Brett household expenses.csv\"")
    |> send_resp(200, csv_content())

  end

  defp csv_content do

    Yaeta.Transactions.list_expenses
    |> Enum.map( fn(%{category: c, description: d, amount: a}) -> [c, d, a] end)
    |> CSV.encode
    |> Enum.to_list
    |> to_string
  end

end
