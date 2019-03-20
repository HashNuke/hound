defmodule Hound.Utils do
  @moduledoc false

  def temp_file_path(prefix, extension) do
    {{year, month, day}, {hour, minutes, seconds}} = :erlang.localtime()
    {:ok, configs} = Hound.configs
    "#{configs[:temp_dir]}/#{prefix}-#{year}-#{month}-#{day}-#{hour}-#{minutes}-#{seconds}.#{extension}"
  end
end
