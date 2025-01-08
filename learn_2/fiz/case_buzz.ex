defmodule Fizz.Buzz do
  def go(min, max), do: Enum.each(min..max, &go/1)
  def go(num) when is_integer(num) and num > 0 do
    case {rem(num, 3), rem(num, 5)} do
      {0, 0} -> IO.puts("fizzbuzz")
      {0, _} -> IO.puts("fizz")
      {_, 0} -> IO.puts("buzz")
      _ -> IO.puts(num)
    end
  end
end
