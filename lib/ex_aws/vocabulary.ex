defmodule ExAws.Vocabulary do
  @moduledoc """
    Operations for AWS Transcribe Vocabulary Endpoints
  """

  import ExAws.Utils, only: [camelize_keys: 2]

  @version "2017-10-26"

  @doc """
    Creates a vocabulary

    Doc: <https://docs.aws.amazon.com/transcribe/latest/dg/API_CreateVocabulary.html>

    Example:
  ```
    Transcribe.create_vocabulary("VocabularyName", "en-US", ["Hello", "World"])
  ```
  """
  @type create_vocabulary_opts :: [
          language_code: binary,
          phrases: list(binary),
          vocabulary_file_uri: binary
        ]
  @spec create_vocabulary(
          name :: binary,
          opts :: create_vocabulary_opts
        ) :: ExAws.Operation.JSON.t()
  def create_vocabulary(name, opts \\ []) do
    params =
      %{
        "VocabularyName" => name
      }
      |> Map.merge(normalize_opts(opts))

    request(:create_vocabulary, params)
  end

  @doc """
  Lists vocabularies

  Doc: <https://docs.aws.amazon.com/transcribe/latest/dg/API_ListVocabularies.html>

  Examples:
  ```
  # List vocabularies
  ExAws.Vocabulary.list_vocabularies()

  # List vocabularies by name
  ExAws.Vocabulary.list_vocabularies(name_contains: "name")
  ```
  """
  @type list_vocabularies_opts :: [
          name_contains: binary,
          max_results: integer,
          next_token: binary,
          state: binary
        ]
  @spec list_vocabularies(opts :: list_vocabularies_opts) :: ExAws.Operation.JSON.t()
  def list_vocabularies(opts \\ []) do
    request(:list_vocabularies, normalize_opts(opts))
  end

  @doc """
  Returns information about a vocabulary

  Doc: <https://docs.aws.amazon.com/transcribe/latest/dg/API_GetVocabulary.html>

  Example:
  ```
  ExAws.Vocabulary.get_vocabulary("Vocabulary1")
  ```
  """
  @spec get_vocabulary(name :: binary) :: ExAws.Operation.JSON.t()
  def get_vocabulary(name) do
    params = %{"VocabularyName" => name}

    request(:get_vocabulary, params)
  end

  @doc """
  Deletes the named vocabulary

  Doc: <https://docs.aws.amazon.com/transcribe/latest/dg/API_DeleteVocabulary.html>

  Example:
  ```
  ExAws.Vocabulary.delete_vocabulary("Vocabulary1")
  ```
  """
  @spec delete_vocabulary(name :: binary) :: ExAws.Operation.JSON.t()
  def delete_vocabulary(name) do
    params = %{"VocabularyName" => name}

    request(:delete_vocabulary, params)
  end

  @doc """
  Updates the named vocabulary
  All words or a file must be specified.

  Doc: <https://docs.aws.amazon.com/transcribe/latest/dg/API_DeleteVocabulary.html>

  Example:
  ```
  ExAws.Vocabulary.delete_vocabulary("Vocabulary1")
  ```
  """
  @type update_vocabulary_opts :: [
          language_code: binary,
          phrases: list(binary),
          vocabulary_file_uri: binary
        ]
  @spec update_vocabulary(name :: binary, opts :: update_vocabulary_opts) ::
          ExAws.Operation.JSON.t()
  def update_vocabulary(name, opts \\ []) do
    params =
      %{
        "VocabularyName" => name
      }
      |> Map.merge(normalize_opts(opts))

    request(:update_vocabulary, params)
  end

  defp request(action, params) do
    operation =
      action
      |> Atom.to_string()
      |> Macro.camelize()

    ExAws.Operation.JSON.new(:transcribe, %{
      data: Map.merge(%{"Version" => @version}, params),
      headers: [
        {"X-Amz-Target", "Transcribe.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"}
      ]
    })
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys(deep: false)
  end
end
