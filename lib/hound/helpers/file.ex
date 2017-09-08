defmodule Hound.Helpers.File do
  @moduledoc "Functions to work with an files"

  import Hound.RequestUtils

  @spec upload(String.t) :: String.t
  def upload(local_file_path) do
    fail_if_webdriver_phantomjs("upload()")

    session_id = Hound.current_session_id
    {:ok, zip_file_path} = local_file_path
                           |> zip()
    zip_file_content = zip_file_path
                       |> File.read!()
                       |> :base64.encode()
    zip_file_path
    |> File.rm()
    make_req(:post, "session/#{session_id}/file", %{file: zip_file_content})
  end

  @spec zip(String.t) :: String.t
  def zip(local_file_path) do



    local_file_name = local_file_path
                      |> Path.basename()
    local_file_name <> ".zip"
    |> to_char_list()
    |> :zip.create(
         [
           {
             local_file_name
             |> to_char_list(),
             local_file_path
             |> File.read!()
           }
         ]
       )
  end

  defp fail_if_webdriver_phantomjs(function) do
    Hound.NotSupportedError.raise_for(%{driver: "phantomjs"}, function)
  end
end
