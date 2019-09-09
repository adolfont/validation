defmodule Validation do

  @type default :: {:ok} | {:error, String.t}

  @moduledoc """
  @TODO: update docs.. wrapper to the rules
  """

  @doc """
  Validates whether the input is a valid MAC address.
  """
  @spec mac_address(String.t) :: default
  def mac_address(input) when is_binary(input) do
    Validation.Rules.MacAddress.validate(input)
  end

  @doc """
  Validates whether the input is alphanumeric.
  """
  @spec alphanumeric(String.t) :: default
  def alphanumeric(input) when is_binary(input) do
    Validation.Rules.Alphanumeric.validate(input)
  end

  @doc """
  Validates whether the input is alphanumeric, excluding specific characters.
  """
  @spec alphanumeric(String.t, String.t) :: Validation.default
  def alphanumeric(input, excluded_characters) when is_binary(input) and is_binary(excluded_characters) do
    Validation.Rules.Alphanumeric.validate(input, excluded_characters)
  end

  @doc """
  Validates ranges.
  """
  @spec between(number, number, number) :: Validation.default
  def between(value, min, max) when is_number(value) and is_number(min) and is_number(max) do
    Validation.Rules.Between.validate(value, min, max)
  end

  @doc """
  Validates if value is considered as "No".
  """
  @spec no(String.t) :: Validation.default
  def no(input) when is_binary(input) do
    Validation.Rules.No.validate(input)
  end

  @doc """
  Validates if value is considered as "Yes".
  """
  @spec yes(String.t) :: Validation.default
  def yes(input) when is_binary(input) do
    Validation.Rules.Yes.validate(input)
  end

  @doc """
  Validates whether the input is even.
  """
  @spec even(Integer.t) :: Validation.default
  def even(input) when is_integer(input) do
    Validation.Rules.Even.validate(input)
  end
end
