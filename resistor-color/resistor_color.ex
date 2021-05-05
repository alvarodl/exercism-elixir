defmodule ResistorColor do
  @moduledoc false

  @color_codes %{
    "black" => 0,
    "brown" => 1,
    "red" => 2,
    "orange" => 3,
    "yellow" => 4,
    "green" => 5,
    "blue" => 6,
    "violet" => 7,
    "grey" => 8,
    "white" => 9
  }

  @spec colors() :: list(String.t())
  def colors do
    @color_codes
    |> Enum.sort_by(fn {key, value} -> value end)
    |> Enum.map(fn {key, value} -> key end)
  end

  @spec code(String.t()) :: integer()
  def code(color) do
    @color_codes
    |> Map.get(color)
  end
end
