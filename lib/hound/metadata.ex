defmodule Hound.Metadata do
  @moduledoc """
  Metadata allows to pass and extract custom data through.
  This can be useful if you need to identify sessions.

  The keys and values must be serializable using `:erlang.term_to_binary/1`.

  ## Examples

  You can start a session using metadata by doing the following:

      Hound.start_session(metadata: %{pid: self()})


  If you need to retrieve the metadata, you simply need to use
  `Hound.Metadata.extract/1` on the user agent string, so supposing you are using plug,


      user_agent =  conn |> get_req_header("user-agent") |> List.first
      metadata   = Hound.Metadata.extract(user_agent)
      assert %{pid: pid} = metadata
      # you can use your pid here

  """

  @metadata_prefix "BeamMetadata"
  @extract_regexp ~r{#{@metadata_prefix} \((.*?)\)}

  @doc """
  Appends the metdata to the user_agent string.
  """
  @spec append(String.t, nil | map | String.t) :: String.t
  def append(user_agent, nil), do: user_agent
  def append(user_agent, metadata) when is_map(metadata) or is_list(metadata) do
    append(user_agent, format(metadata))
  end
  def append(user_agent, metadata) when is_binary(metadata) do
    "#{user_agent}/#{metadata}"
  end

  @doc """
  Formats a string to a valid UserAgent string to be passed to be
  appended to the browser user agent.
  """
  @spec format(map | Keyword.t) :: String.t
  def format(metadata) do
    encoded = {:v1, metadata} |> :erlang.term_to_binary |> Base.url_encode64
    "#{@metadata_prefix} (#{encoded})"
  end

  @doc """
  Extracts and parses the metadata contained in a user agent string.
  If the user agent does not contain any metadata, an empty map is returned.
  """
  @spec parse(String.t) :: %{String.t => String.t}
  def extract(str) do
    ua_last_part = str |> String.split("/") |> List.last
    case Regex.run(@extract_regexp, ua_last_part) do
      [_, metadata] -> parse(metadata)
      _             -> %{}
    end
  end

  defp parse(encoded_metadata) do
    encoded_metadata
    |> Base.url_decode64!
    |> :erlang.binary_to_term
    |> case do
         {:v1, metadata} -> metadata
         _               -> raise Hound.InvalidMetadataError, value: encoded_metadata
    end
  end
end
