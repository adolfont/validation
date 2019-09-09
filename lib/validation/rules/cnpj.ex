defmodule Validation.Rules.CNPJ do

  @doc """
  Validates whether the input is a valid CNPJ.
  """
  @spec validate(String.t) :: Validation.default
  def validate(input) when is_binary(input) do
    # Ugly code. But it works.
    # Code ported from jsfromhell.com

    # only numbers
    digits = Regex.replace(~r/\D/, input, "")

    bases = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

    if not validate_digits_sum(digits) || String.length(digits) != 14 do
      error_result()
    else
      {_, n} = Enum.map_reduce(0..11, 0, fn i, n ->
        digit_item = String.at(digits, i) |> String.to_integer
        base_item  = Enum.at(bases, i + 1)

        n = n + (digit_item * base_item)

        {i, n}
      end)

      n = rem(n, 11)

      digit_12 = String.at(digits, 12) |> String.to_integer
      check    = if n < 2, do: 0 , else: 11 - n

      if digit_12 != check do
        error_result()
      else
        _ = """
        $check = ($n %= 11) < 2 ? 0 : 11 - $n;
        return $digits[13] == $check;
        """
        {_, n} = Enum.map_reduce(0..12, 0, fn i, n ->
          digit_item = String.at(digits, i) |> String.to_integer
          base_item  = Enum.at(bases, i)

          n = n + (digit_item * base_item)

          {i, n}
        end)

        n = rem(n, 11)

        digit_13 = String.at(digits, 13) |> String.to_integer
        check    = if n < 2, do: 0, else: 11 - n

        if digit_13 == check do
          {:ok}
        else
          error_result()
        end
      end
    end
  end

  def error_result do
    {:error, "Invalid CNPJ input."}
  end

  defp validate_digits_sum(digits_string) do
    {_, sum} =
      digits_string
      |> String.codepoints
      |> Enum.map_reduce(0, fn digit, total ->
        digit = String.to_integer(digit)
        {digit, total + digit}
      end)

    sum > 0
  end
end