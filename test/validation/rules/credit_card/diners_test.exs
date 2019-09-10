defmodule Validation.Rules.CreditCard.DinersTest do
  use ExUnit.Case
  alias Validation.Rules.CreditCard.Diners, as: V
  doctest Validation

  test "valid credit card - diners" do
    assert {:ok} = V.validate("30351042633884")
  end

  test "invalid credit card - diners" do
    assert {:error, _} = V.validate("340-3161-9380-9364")   # amex
    assert {:error, _} = V.validate("6011000990139424")     # discover
    assert {:error, _} = V.validate("3566002020360505")     # jcb
    assert {:error, _} = V.validate("5376 7473 9720 8720")  # master
    assert {:error, _} = V.validate("2222 4000 4124 0011")  # master
    assert {:error, _} = V.validate("4024.0071.5336.1885")  # visa
    assert {:error, _} = V.validate("4024 007 193 879")     # visa
  end
end
