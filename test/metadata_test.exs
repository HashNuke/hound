defmodule Hound.MetadataTest do
  use ExUnit.Case

  use Hound.Helpers

  alias Hound.Metadata

  @ua "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1"

  test "format produces UA compatible string" do
    assert Metadata.format(%{foo: "foo", bar: "baz"}) =~ ~r{BeamMetadata \([a-zA-Z0-9=-_]+\)}
  end

  test "extract returns empty map when no match" do
    assert Metadata.extract(@ua) == %{}
  end

  test "extract raises when data cannot be parsed" do
    assert_raise ArgumentError, fn ->
      Metadata.extract("#{@ua}/BeamMetadata (some random string)")
    end

    assert_raise Hound.InvalidMetadataError, fn ->
      bad_data = {:v123, "foobar"} |> :erlang.term_to_binary |> Base.encode64
      Metadata.extract("#{@ua}/BeamMetadata (#{bad_data})")
    end
  end

  test "extract returns metadata" do
    ua = Metadata.append(@ua, %{foo: "bar", baz: "qux"})
    assert Metadata.extract(ua) == %{foo: "bar", baz: "qux"}
  end

  test "accepts complex values" do
    metadata = %{ref: make_ref(), pid: self(), list: [1, 2, 3]}
    assert Metadata.extract(Metadata.append(@ua, metadata)) == metadata
  end

  test "metadata is passed to the browser through user agent" do
    metadata = %{my_pid: self()}
    Hound.start_session(metadata: metadata)
    navigate_to "http://localhost:9090/page1.html"
    ua = execute_script("return navigator.userAgent;", [])
    assert Metadata.extract(ua) == metadata
    Hound.end_session
  end
end
