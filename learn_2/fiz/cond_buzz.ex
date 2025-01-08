defmodule Fizz.Buzz do
  def go(min, max), do: Enum.each(min..max, &go/1)

  def go(num) when is_integer(num) and num > 0 do
    cond do
      rem(num, 15) == 0 -> IO.puts("fizzbuzz")
      rem(num, 3) == 0 -> IO.puts("fizz")
      rem(num, 5) == 0 -> IO.puts("buzz")
      true -> IO.puts(num)
    end
  end
end
