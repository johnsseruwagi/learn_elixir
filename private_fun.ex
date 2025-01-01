defmodule TestPrivate do
	def double(a), do: sum(a,a)
	defp sum(a,b), do: a + b
end
