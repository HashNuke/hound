defmodule Hound.SessionBehaviour do
  use Behaviour
#--- Session

  @doc "Get server's current status"
  defcallback status() :: Dict.t

  @doc "Get list of active sessions"
  defcallback active_sessions() :: Dict.t

  @doc "Create a session"
  defcallback create() :: String.t

  @doc "Get capabilities of a particular session"
  defcallback session(session_id :: String.t) :: Dict.t

  @doc "Delete a session"
  defcallback delete_session(session_id :: String.t) :: :ok

  @doc "Set the timeout for a particular type of operation"
  defcallback set_timeout(operation :: String.t, time :: Integer.t) :: :ok

# #-- Navigation

#   @doc "Get url of the current page"
#   defcallback current_url(session_id)

#   @doc "Navigate to a url"
#   defcallback navigate_to(session_id, url)

#   @doc "Navigate forward in browser history"
#   defcallback navigate_forward(session_id)

#   @doc "Navigate back in browser history"
#   defcallback navigate_back(session_id)

#   @doc "Refresh current page"
#   defcallback refresh(session_id)

# #--- Browser

#   @doc "Get browser's orientation"
#   defcallback orientation(session_id)

#   @doc "Set browser's orientation"
#   defcallback set_orientation(session_id, orientation)


# #--- ScriptExecution

#   @doc "Execute javascript synchoronously"
#   defcallback execute_script(session_id, script_function, function_args)

#   @doc "Execute javascript asynchoronously"
#   defcallback execute_script_async(session_id, script_function, function_args)

# #--- Utils

#   @doc "Take screenshot of the current page"
#   defcallback take_screenshot(session_id)

# #--- IME

#   @doc "List available IME engines"
#   defcallback available_ime_engines(session_id)

#   @doc "Get name of active IME engine"
#   defcallback active_ime_engine(session_id)

#   @doc "Checks if the IME input is currently active"
#   defcallback ime_active?(session_id)

#   @doc "Activate IME engine"
#   defcallback activate_ime_engine(session_id, engine_name)

#   @doc "Deactivate currently active IME engine"
#   defcallback deactivate_current_ime_engine(session_id)

# #--- Window

#   @doc "Get all window handles available to the session"
#   defcallback current_window_handle(session_id)

#   @doc "Get list of window handles available to the session"
#   defcallback window_handles(session_id)

#   @doc "Change focus to frame"
#   defcallback focus_frame(session_id, frame_identifier)

#   @doc "Change focus to another window"
#   defcallback focus_window(session_id, window_identifier)

#   @doc "Close current window"
#   defcallback close_current_window(session_id)

#   @doc "Change size of window"
#   defcallback set_window_size(session_id, window_handle, size)

#   @doc "Get window size"
#   defcallback window_size(session_id, window_handle)

#   @doc "Get window position"
#   defcallback window_position(session_id, window_handle)

#   @doc "Set window position"
#   defcallback set_window_position(session_id, window_handle, position)

#   @doc "Maximize window"
#   defcallback set_window_position(session_id, window_handle)

#   @doc "Get cookies"
#   defcallback cookies(session_id)

#   @doc "Set cookie"
#   defcallback set_cookie(session_id, cookie)

#   @doc "Delete all cookies for the current page"
#   defcallback delete_cookies(session_id)

#   @doc "Delete cookie"
#   defcallback delete_cookie(session_id, name)

#   @doc "Get source of current page"
#   defcallback source(session_id)

#   @doc "Get the title of the current page"
#   defcallback title(session_id)

#   @doc "Find element on current page"
#   defcallback find_element(session_id, strategy, selector)

#   @doc "Find elements on current page"
#   defcallback find_elements(session_id, strategy, selector)

#   @doc "Get element on page currently in focus"
#   defcallback element_in_focus(session_id)

#   @doc "Find element within element"
#   defcallback find_element_within_element(session_id, strategy, selector)

#   @doc "Find elements within element"
#   defcallback find_elements_within_element(session_id, strategy, selector)

#   @doc "Click on element"
#   defcallback click_on(session_id, element_identifier)

#   @doc "Submit form"
#   defcallback submit(session_id, element_identifier)

#   @doc "Get visible text of element"
#   defcallback visible_text(session_id, element_identifier)

#   @doc "Set value of element. Sends a sequence of key strokes"
#   defcallback set_value(session_id, element_identifier, value)

#   @doc "Send sequence of key strokes to active element. The modifier keys are not released after this command is run."
#   defcallback send_keys(session_id, keys)

#   @doc "Get an element's tag name"
#   defcallback tag_name(session_id, element_identifier)

#   @doc "Clear textarea or input element's value"
#   defcallback clear_field(session_id, element_identifier)

#   @doc "Check if a checkbox or radio input group has any option selected"
#   defcallback selected?(session_id, element_identifier)

#   @doc "Check if an input field is enabled"
#   defcallback enabled?(session_id, element_identifier)

#   @doc "Get an element's attribute value"
#   defcallback attribute_value(session_id, element_identifier, attribute_name)

#   @doc "Check if two element IDs refer to the same DOM element"
#   defcallback same?(session_id, element_identifier1, element_identifier2)

#   @doc "Check if an element is currently displayed"
#   defcallback displayed?(session_id, element_identifier)

#   @doc "Get element's location on page"
#   defcallback element_location(session_id, element_identifier)

#   @doc "Check if an element's location on screen has been scrolled into view"
#   defcallback element_in_view?(session_id, element_identifier)

#   @doc "Get element size pixels"
#   defcallback element_size(session_id, element_identifier)

#   @doc "Get an element's computed CSS property"
#   defcallback css_property(session_id, element_identifier, property_name)


# #--- Javascript dialog

#   @doc "Get text of a javascript alert(), confirm() or prompt()"
#   defcallback dialog_text(session_id)

#   @doc "Send input to a javascript prompt()"
#   defcallback input_into_prompt(session_id, input)

#   @doc "Accept javascript dialog"
#   defcallback accept_dialog(session_id)

#   @doc "Dismiss javascript dialog"
#   defcallback dismiss_dialog(session_id)

end