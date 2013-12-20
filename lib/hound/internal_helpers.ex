defmodule Hound.InternalHelpers do
  @moduledoc false

  def selector_strategy(:class), do: "class name"
  def selector_strategy(:css), do: "css selector"
  def selector_strategy(:id), do: "id"
  def selector_strategy(:name), do: "name"
  def selector_strategy(:link_text), do: "link text"
  def selector_strategy(:partial_link_text), do: "partial link text"
  def selector_strategy(:tag), do: "tag name"
  def selector_strategy(:xpath), do: "xpath"
end
