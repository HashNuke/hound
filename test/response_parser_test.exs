defmodule ResponseParserTest do
  use ExUnit.Case

  alias Hound.ResponseParser

  defmodule DummyParser do
    use Hound.ResponseParser
  end

  defmodule DummyCustomErrorParser do
    use Hound.ResponseParser

    def handle_error(%{"message" => "some error"}) do
      "custom handler"
    end
  end

  test "parse/2" do
    body = ~s({"sessionId": 1})
    assert ResponseParser.parse(DummyParser, "session", 200, [], body) == {:ok, 1}
  end

  test "parse/2 with 204 no-content response" do
    assert ResponseParser.parse(DummyParser, "session", 204, [], "") == :ok
  end

  test "handle_response/3 session" do
    assert DummyParser.handle_response("session", 200, %{"sessionId" => 1}) == {:ok, 1}
    assert DummyParser.handle_response("session", 400, %{"sessionId" => 1}) == :error
  end

  test "handle_response/3 errors" do
    body = %{"value" => %{"message" => "error"}}
    assert DummyParser.handle_response("foo", 200, body) == {:error, "error"}
    body = %{"value" => %{"message" => "some error"}}
    assert DummyCustomErrorParser.handle_response("foo", 200, body) == "custom handler"
    body = %{"value" => %{"message" => "other error"}}
    assert DummyCustomErrorParser.handle_response("foo", 200, body) == {:error, "other error"}
  end

  test "handle_response/3 value" do
    assert DummyParser.handle_response("foo", 200, %{"status" => 0, "value" => "value"}) == "value"
  end

  test "handle_response/3 success" do
    assert DummyParser.handle_response("foo", 200, "whatever") == :ok
  end

  test "handle_response/3 error" do
    assert DummyParser.handle_response("foo", 500, "whatever") == :error
  end
end
