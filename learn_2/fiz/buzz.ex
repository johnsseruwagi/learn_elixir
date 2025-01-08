defmodule Fiz.Buzz do
  def go(min, max) do
    min..max
    |> Enum.each(&go(&1))
  end

  def go(num) when is_integer(num) and num > 0 and rem(num, 15) == 0, do: IO.puts("fizzbuzz")
  def go(num) when is_integer(num) and num > 0 and rem(num, 3) == 0, do: IO.puts("fizz")
  def go(num) when is_integer(num) and num > 0 and rem(num, 5) == 0, do: IO.puts("fizz")
  def go(num), do: IO.puts(num)
end
