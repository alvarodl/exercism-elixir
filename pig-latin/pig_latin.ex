defmodule PigLatin do

  @special ["ch", "qu", "squ", "thr", "th", "sch"]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&latinize/1)
    |> Enum.join(" ")
  end

  defp latinize(word) do
    if String.starts_with?(word, @special) do
      translate_word_special(word)
    else
      translate_word(word)
    end
  end

  defp translate_word_special(word) do

    [head | tail] = @special
      |> Enum.join("|")
      |> Regex.compile!()
      |> Regex.split(word, include_captures: true, trim: true)

    Enum.join(tail ++ [head] ++ ["ay"])
  end

  defp translate_word(word) do
    [head | tail] = String.split(word, ~R/[aeiou]|x[^aeiou]|y[^aeiou].*/, include_captures: true)

    Enum.join(tail ++ [head] ++ ["ay"])
  end
end
