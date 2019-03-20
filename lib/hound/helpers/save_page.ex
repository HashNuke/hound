defmodule Hound.Helpers.SavePage do
  @moduledoc "Provides helper function to save the current page"

  import Hound.RequestUtils

  @doc """
  Save the dom of the current page. The page is saved in the current working directory.
  It returns the path of the html file, to which the dom has been saved.

  For Elixir mix projects, the saved screenshot can be found in the root of the project directory.

      save_page()

  You can also pass a file path to which the screenshot must be saved to.

      # Pass a full file path
      save_page("/media/pages/test.html")

      # Or you can also pass a path relative to the current directory. save_page("page.html")
  """
  @spec save_page(String.t) :: String.t
  def save_page(path \\ default_path()) do
    session_id = Hound.current_session_id
    page_data = make_req(:get, "session/#{session_id}/source")

    :ok = File.write path, page_data
    path
  end

  defp default_path do
    Hound.Utils.temp_file_path("page", "html")
  end

end
