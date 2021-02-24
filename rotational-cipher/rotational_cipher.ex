defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&(applyShift(&1, shift)))
    |> to_string
  end

  def applyShift(letter, shift) do
    cond do
      letter in ?A..?Z -> ?A + rem(letter - ?A + shift, 26)
      letter in ?a..?z -> ?a + rem(letter - ?a + shift, 26)
      true             -> letter
    end
  end
end