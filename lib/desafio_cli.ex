defmodule DesafioCli do
  @moduledoc """
  Ponto de entrada para a CLI.
  """

  @doc """
  A função main recebe os argumentos passados na linha de
  comando como lista de strings e executa a CLI.
  """
  def main(_args) do
    IO.puts("Database CLI started.")
    start(0, %{}, [])
  end

  def start(connection_count, db, transactions) do
    command = IO.gets("> ") |> String.trim()
    IO.puts("Command received: #{command}")
    start(connection_count, db, transactions)
  end
end
