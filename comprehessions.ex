defmodule Comprehension do

  @moduledoc """
  This gives helper functions to help understand
  the concept of comprehension
  """
  @doc """
  list_square([]) uses pattern matching
  and multi clauses to return and empty
  list if an empty list is given as an
  argument
  """
  def list_square([]), do: []

  def list_square(list) do
    for x <- list do
      x * x
    end
  end

  @doc """
  multi-clause function that demonstrates the power
  of comprehension over the Enum module
  by performing nested iterations,
  """
  def list_square(list_1, list_2) do
    for x <- list_1, y <- list_2, do: {x, y, x * y}
  end

  def multiplication_table(list_1, list_2) do
    for x <- list_1,
        y <- list_2,
        into: %{} do
          {{x, y}, x * y}
        end
  end

  @doc """
  comprehensions can also be used with filters
  """

  def multiplication_table(:filter,list_1, list_2) do
    for x <- list_1,
        y <- list_2,
        x <= y,
        into: %{} do
          {{x, y}, x * y}
        end
  end
end
