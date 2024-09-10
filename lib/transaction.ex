defmodule DesafioCli.Transaction do
  alias DesafioCli

  def open(connection_count, db, transactions) do
    new_count = connection_count + 1
    # Adiciona nova transação (nova camada)
    transactions = [%{} | transactions]
    DesafioCli.start(new_count, db, transactions)
  end

  def set_key_value(connection_count, db, transactions, key, value) do
    if connection_count == 0 do
      IO.puts("No active transactions.")
      DesafioCli.start(connection_count, db, transactions)
    else
      [latest_txn | rest] = transactions
      new_txn = Map.put(latest_txn, key, value)

      case Map.get(latest_txn, key) do
        nil ->
          IO.puts("FALSE #{value}")
          DesafioCli.start(connection_count, db, [new_txn | rest])

        _ ->
          IO.puts("TRUE #{value}")
          DesafioCli.start(connection_count, db, [new_txn | rest])
      end
    end
  end

  def get_key_value(connection_count, db, transactions, key) do
    value = get_value_from_transactions(key, transactions) || Map.get(db, key, nil)
    IO.puts(value || inspect(NIL))
    DesafioCli.start(connection_count, db, transactions)
  end

  def commit_transactions(connection_count, db, transactions) do
    if connection_count == 0 do
      IO.puts("No active transactions to commit.")
      DesafioCli.start(connection_count, db, transactions)
    else
      IO.puts(connection_count)
      db = Enum.reduce(transactions, db, fn txn, acc -> Map.merge(acc, txn) end)
      # Reseta as transações após o commit
      DesafioCli.start(0, db, [])
    end
  end

  def rollback_transactions(connection_count, db, transactions) do
    if connection_count == 0 do
      IO.puts("No active transactions to rollback.")
      DesafioCli.start(connection_count, db, transactions)
    else
      IO.puts("Rolling back last transaction.")
      # Remove a transação mais recente
      DesafioCli.start(connection_count - 1, db, tl(transactions))
    end
  end

  defp get_value_from_transactions(key, []), do: nil

  defp get_value_from_transactions(key, [latest_txn | rest]) do
    case Map.get(latest_txn, key) do
      nil -> get_value_from_transactions(key, rest)
      value -> value
    end
  end
end
