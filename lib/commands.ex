defmodule DesafioCli.Commands do
  alias DesafioCli.Transaction

  def begin(connection_count, db, transactions) do
    IO.puts(connection_count + 1)
    Transaction.open(connection_count, db, transactions)
  end

  def set(connection_count, db, transactions, key, value) do
    Transaction.set_key_value(connection_count, db, transactions, key, value)
  end

  def get(connection_count, db, transactions, key) do
    Transaction.get_key_value(connection_count, db, transactions, key)
  end

  def commit(connection_count, db, transactions) do
    Transaction.commit_transactions(connection_count, db, transactions)
  end

  def rollback(connection_count, db, transactions) do
    Transaction.rollback_transactions(connection_count, db, transactions)
  end
end
