defmodule ElementTest do
  use ExUnit.Case

  alias Hound.Element

  test "encoding to JSON" do
    uuid = "some-uuid"
    element = %Element{uuid: uuid}
    assert Jason.encode!(element) == ~s({"ELEMENT":"#{uuid}"})
  end

  test "string representation" do
    uuid = "some-uuid"
    element = %Element{uuid: uuid}
    assert to_string(element) == uuid
  end

  test "element?/1" do
    assert Element.element?(%Element{uuid: "foo"})
    refute Element.element?("foo")
  end

  test "from_response/1" do
    assert Element.from_response(%{"ELEMENT" => "uuid"}) == %Element{uuid: "uuid"}
    assert_raise Hound.InvalidElementError, fn -> Element.from_response(%{"value" => "foo"}) end
  end
end
