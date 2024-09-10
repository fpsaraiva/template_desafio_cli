defmodule DesafioCli do
  alias DesafioCli.Commands

  @moduledoc """
  Ponto de entrada para a CLI.
  """

  @doc """
  A função main recebe os argumentos passados na linha de
  comando como lista de strings e executa a CLI.
  """
  def main(_args) do
    start(0, %{}, [])
  end

  def start(connection_count, db, transactions) do
    input = IO.gets("> ") |> String.trim()

    case String.split(input, ~r/\s+/) do
      ["BEGIN"] ->
        Commands.begin(connection_count, db, transactions)
        start(connection_count, db, transactions)

      ["SET", key, value] ->
        Commands.set(connection_count, db, transactions, key, value)
        start(connection_count, db, transactions)

      ["GET", key] ->
        Commands.get(connection_count, db, transactions, key)
        start(connection_count, db, transactions)

      ["COMMIT"] ->
        Commands.commit(connection_count, db, transactions)
        start(connection_count, db, transactions)

      ["ROLLBACK"] ->
        Commands.rollback(connection_count, db, transactions)
        start(connection_count, db, transactions)

      _ ->
        IO.puts("ERR \"No command #{input}\"")
        start(connection_count, db, transactions)
    end
  end
end
