defmodule ProteinTranslation do
  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    list_codons = list_codons(rna)

    valid_proteins(list_codons)
    |> to_response()
  end

  defp list_codons(rna) do
    for <<x::binary-3 <- rna>>, do: x
    |> of_codon()
  end

  defp valid_proteins(codons) do
    Keyword.values(codons)
    |> Enum.reduce_while(
      [],
      fn element, accumulator ->
        case element do
          "invalid codon" -> {:halt, []}
          "STOP" -> {:halt, accumulator}
          _ -> {:cont, accumulator ++ [element]}
        end
      end
    )
  end

  defp to_response(proteins) do
    case proteins do
      [] -> {:error, "invalid RNA"}
      _ -> {:ok, proteins}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    if Enum.member?(Map.keys(@proteins), codon) do
      {:ok, Map.get(@proteins, codon)}
    else
      {:error, "invalid codon"}
    end
  end
end
