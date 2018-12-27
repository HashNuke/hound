defmodule Hound.Browser.Firefox.Profile do
  @moduledoc false

  @default_prefs %{
  }

  defstruct [prefs: @default_prefs]

  def new do
    %__MODULE__{}
  end

  def get_preference(%__MODULE__{prefs: prefs}, key) do
    Map.get(prefs, key)
  end

  def put_preference(profile, key, value) do
    %{profile | prefs: Map.put(profile.prefs, key, value)}
  end

  def set_user_agent(profile, user_agent) do
    put_preference(profile, "general.useragent.override", user_agent)
  end

  def serialize_preferences(profile) do
    profile.prefs
    |> Enum.map_join("\n", fn {key, value} ->
      ~s[user_pref("#{key}", #{Jason.encode!(value)});]
    end)
  end

  def dump(profile) do
    files = [{'user.js', serialize_preferences(profile)}]
    case :zip.create('profile.zip', files, [:memory]) do
      {:ok, {_filename, binary}} ->
        {:ok, Base.encode64(binary)}
      {:error, _reason} = error ->
        error
    end
  end
end
