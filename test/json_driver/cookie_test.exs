defmodule CookieTest do
  use ExUnit.Case
  use Hound.Helpers

  setup do
    Hound.start_session
    :ok
  end

  teardown do
    # NOTE PhantomJs uses the same cookie jar for all sessions.
    # We'll delete cookies after each session, because we only want to test our APIs
    delete_cookies()
    Hound.end_session
    :ok
  end


  test "should set a cookie" do
    navigate_to "http://localhost:9090/page1.html"
    cart_id = "12v3q4rsdv"
    set_cookie([name: "cart_id", value: cart_id])
    valid_cookie = Enum.find(cookies(), fn(cookie)-> cookie["name"]=="cart_id" end)

    assert valid_cookie["value"] == cart_id
  end


  test "should get cookies on page" do
    navigate_to "http://localhost:9090/page1.html"
    set_cookie([name: "example", value: "12v3q4rsdv"])

    assert length(cookies()) == 1
  end


  test "should delete a cookie" do
    navigate_to "http://localhost:9090/page1.html"
    cart_id = "12v3q4rsdv"
    set_cookie([name: "cart_id", value: cart_id])
    set_cookie([name: "cart_status", value: "active"])


    assert length(cookies()) == 2
    delete_cookie("cart_id")
    assert length(cookies()) == 1
  end


  test "should delete all cookies" do
    navigate_to "http://localhost:9090/page1.html"
    cart_id = "12v3q4rsdv"
    set_cookie([name: "cart_id", value: cart_id])
    set_cookie([name: "cart_status", value: "active"])

    assert length(cookies()) == 2
    delete_cookies()
    assert length(cookies()) == 0
  end
end
