defmodule FileTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "must upload the file to a remote server" do
    local_file_path = "./test/sample_files/test.txt"
    if is_webdriver_phantomjs() do
      assert_raise Hound.NotSupportedError, "upload() is not supported by driver phantomjs with browser phantomjs", fn ->
        local_file_path
        |> upload()
      end
    else
      file_path_type = local_file_path
                       |> upload()
      assert is_binary(file_path_type)
    end
  end

  defp is_webdriver_phantomjs() do
    match?({:ok, %{driver: "phantomjs"}}, Hound.driver_info)
  end

end
