defmodule DatabaseCLI.TransactionTest do
  use ExUnit.Case
  alias DesafioCli.Transaction

  test "get a value from a transaction" do
    transactions = [%{"name" => "Fernando"} | []]
    value = Transaction.get_value_from_transactions("name", transactions)
    assert value == "Fernando"
  end

  test "get NIL from a transaction" do
    transactions = [%{} | []]
    value = Transaction.get_value_from_transactions("name", transactions)
    assert value == nil
  end
end
