defmodule Hound.Browser.Firefox.ProfileTest do
  use ExUnit.Case

  alias Hound.Browser.Firefox.Profile

  test "new/1 returns a new Profile" do
    assert %Profile{} = Profile.new
  end

  test "get_preference/2 returns the preference value or nil" do
    profile = Profile.new |> Profile.put_preference("foo", "bar")
    assert Profile.get_preference(profile, "foo") == "bar"
    refute Profile.get_preference(profile, "bar")
  end

  test "put_preference/3 set the preference to the profile" do
    profile = Profile.new
    refute Profile.get_preference(profile, "foo")
    profile = Profile.put_preference(profile, "foo", "bar")
    assert Profile.get_preference(profile, "foo") == "bar"
  end

  test "serialize_preferences/1 returns profile serialized as JS" do
    profile =
      Profile.new
      |> Profile.put_preference("foo", "bar")
      |> Profile.put_preference("bar", 3)
    serialized = Profile.serialize_preferences(profile)
    assert serialized =~ ~s{user_pref("foo", "bar");}
    assert serialized =~ ~s{user_pref("bar", 3);}
  end

  test "dump/1 returns a valid base64 profile" do
    profile =
      Profile.new
      |> Profile.put_preference("foo", "bar")
      |> Profile.put_preference("bar", 3)
    assert {:ok, b64_profile} = Profile.dump(profile)
    {:ok, files} = :zip.extract(Base.decode64!(b64_profile), [:memory])
    assert [{'user.js', user_prefs}] = files
    assert user_prefs =~ ~s{user_pref("foo", "bar");}
    assert user_prefs =~ ~s{user_pref("bar", 3);}
  end
end
