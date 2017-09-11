defmodule Hound.InternalHelpers do
  @moduledoc false

  @unsupported_features [
    phantomjs: [
      "dialog_text",
      "input_into_prompt",
      "accept_dialog",
      "dismiss_dialog",
      "delete_cookies",
      "focus_parent_frame"
    ],
    chrome_driver: [],
    selenium: []
  ]


  def selector_strategy(:class), do: "class name"
  def selector_strategy(:css),   do: "css selector"
  def selector_strategy(:id),    do: "id"
  def selector_strategy(:name),  do: "name"
  def selector_strategy(:tag),   do: "tag name"
  def selector_strategy(:xpath), do: "xpath"
  def selector_strategy(:link_text), do: "link text"
  def selector_strategy(:partial_link_text), do: "partial link text"

  def key_code(:null),      do: "\\uE000"
  def key_code(:cancel),    do: "\\uE001"
  def key_code(:help),      do: "\\uE002"
  def key_code(:backspace), do: "\\uE003"
  def key_code(:tab),       do: "\\uE004"
  def key_code(:clear),     do: "\\uE005"
  def key_code(:return),    do: "\\uE006"
  def key_code(:enter),     do: "\\uE007"
  def key_code(:shift),     do: "\\uE008"
  def key_code(:control),   do: "\\uE009"
  def key_code(:alt),       do: "\\uE00A"
  def key_code(:pause),     do: "\\uE00B"
  def key_code(:escape),    do: "\\uE00C"

  def key_code(:space),       do: "\\eE00D"
  def key_code(:pageup),      do: "\\uE00E"
  def key_code(:pagedown),    do: "\\uE00F"
  def key_code(:end),         do: "\\uE010"
  def key_code(:home),        do: "\\uE011"
  def key_code(:left_arrow),  do: "\\uE012"
  def key_code(:up_arrow),    do: "\\uE013"
  def key_code(:right_arrow), do: "\\uE014"
  def key_code(:down_arrow),  do: "\\uE015"
  def key_code(:insert),      do: "\\uE016"
  def key_code(:delete),      do: "\\uE017"
  def key_code(:semicolon),   do: "\\uE018"
  def key_code(:equals),      do: "\\uE019"

  def key_code(:num0),      do: "\\uE01A"
  def key_code(:num1),      do: "\\uE01B"
  def key_code(:num2),      do: "\\uE01C"
  def key_code(:num3),      do: "\\uE01D"
  def key_code(:num4),      do: "\\uE01E"
  def key_code(:num5),      do: "\\uE01F"
  def key_code(:num6),      do: "\\uE020"
  def key_code(:num7),      do: "\\uE021"
  def key_code(:num8),      do: "\\uE022"
  def key_code(:num9),      do: "\\uE023"

  def key_code(:multiply),  do: "\\uE024"
  def key_code(:add),       do: "\\uE025"
  def key_code(:seperator), do: "\\uE026"
  def key_code(:subtract),  do: "\\uE027"
  def key_code(:decimal),   do: "\\uE028"
  def key_code(:divide),    do: "\\uE029"

  def key_code(:command),   do: "\\uE03D"

  def key_codes_json(keys) do
    unicode_string = Enum.map_join(keys, ",", fn(key)-> "\"#{key_code(key)}\"" end)
    "{\"value\": [#{unicode_string}]}"
  end


  def driver_supports?(feature) do
    {:ok, driver_info} = Hound.driver_info
    driver = String.to_atom(driver_info[:driver])

    not Enum.member?(@unsupported_features[driver], feature)
  end

end
