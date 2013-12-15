defprotocol Session do

#--- Session

  @doc "Create a session"
  def create()

  @doc "Get list of active sessions"
  def active_sessions()

  @doc "Get capabilities of a particular session"
  def session(session_id)

  @doc "Delete a session"
  def delete_session(session_id)

  @doc "Set the timeout for a particular type of operation"
  def set_timeout(operation, time)

#-- Navigation

  @doc "Get url of the current page"
  def current_url(session_id)

  @doc "Navigate to a url"
  def navigate_to(session_id, url)

  @doc "Navigate forward in browser history"
  def navigate_forward(session_id)

  @doc "Navigate back in browser history"
  def navigate_back(session_id)

  @doc "Refresh current page"
  def refresh(session_id)

#--- Browser

  @doc "Get browser's orientation"
  def orientation(session_id)

  @doc "Set browser's orientation"
  def set_orientation(session_id, orientation)


#--- ScriptExecution

  @doc "Execute javascript synchoronously"
  def execute_script(session_id, script_function, function_args)

  @doc "Execute javascript asynchoronously"
  def execute_script_async(session_id, script_function, function_args)

#--- Utils

  @doc "Take screenshot of the current page"
  def take_screenshot(session_id)

#--- IME

  @doc "List available IME engines"
  def available_ime_engines(session_id)

  @doc "Get name of active IME engine"
  def active_ime_engine(session_id)

  @doc "Checks if the IME input is currently active"
  def ime_active?(session_id)

  @doc "Activate IME engine"
  def activate_ime_engine(session_id, engine_name)

  @doc "Deactivate currently active IME engine"
  def deactivate_current_ime_engine(session_id)

#--- Window

  @doc "Get all window handles available to the session"
  def current_window_handle(session_id)

  @doc "Get list of window handles available to the session"
  def window_handles(session_id)

  @doc "Change focus to frame"
  def focus_frame(session_id, frame_identifier)

  @doc "Change focus to another window"
  def focus_window(session_id, window_identifier)

  @doc "Close current window"
  def close_current_window(session_id)

  @doc "Change size of window"
  def set_window_size(session_id, window_handle, size)

  @doc "Get window size"
  def window_size(session_id, window_handle)

  @doc "Get window position"
  def window_position(session_id, window_handle)

  @doc "Set window position"
  def set_window_position(session_id, window_handle, position)

  @doc "Maximize window"
  def set_window_position(session_id, window_handle)

  @doc "Get cookies"
  def cookies(session_id)

  @doc "Set cookie"
  def set_cookie(session_id, cookie)

  @doc "Delete all cookies for the current page"
  def delete_cookies(session_id)

  @doc "Delete cookie"
  def delete_cookie(session_id, name)

  @doc "Get source of current page"
  def source(session_id)

  @doc "Get the title of the current page"
  def title(session_id)

  @doc "Find element on current page"
  def find_element(session_id, strategy, selector)

  @doc "Find elements on current page"
  def find_elements(session_id, strategy, selector)

  @doc "Get element on page currently in focus"
  def element_in_focus(session_id)

  @doc "Find element within element"
  def find_element_within_element(session_id, strategy, selector)

  @doc "Find elements within element"
  def find_elements_within_element(session_id, strategy, selector)

  @doc "Click on element"
  def click_on(session_id, element_identifier)

  @doc "Submit form"
  def submit(session_id, element_identifier)

  @doc "Get visible text of element"
  def visible_text(session_id, element_identifier)

  @doc "Set value of element. Sends a sequence of key strokes"
  def set_value(session_id, element_identifier, value)

  @doc "Send sequence of key strokes to active element. The modifier keys are not released after this command is run."
  def send_keys(session_id, keys)

  @doc "Get an element's tag name"
  def tag_name(session_id, element_identifier)

  @doc "Clear textarea or input element's value"
  def clear_field(session_id, element_identifier)

  @doc "Check if a checkbox or radio input group has any option selected"
  def selected?(session_id, element_identifier)

  @doc "Check if an input field is enabled"
  def enabled?(session_id, element_identifier)

  @doc "Get an element's attribute value"
  def attribute_value(session_id, element_identifier, attribute_name)

  @doc "Check if two element IDs refer to the same DOM element"
  def same?(session_id, element_identifier1, element_identifier2)

  @doc "Check if an element is currently displayed"
  def displayed?(session_id, element_identifier)

  @doc "Get element's location on page"
  def element_location(session_id, element_identifier)

  @doc "Check if an element's location on screen has been scrolled into view"
  def element_in_view?(session_id, element_identifier)

  @doc "Get element size pixels"
  def element_size(session_id, element_identifier)

  @doc "Get an element's computed CSS property"
  def css_property(session_id, element_identifier, property_name)


#--- Javascript dialog

  @doc "Get text of a javascript alert(), confirm() or prompt()"
  def dialog_text(session_id)

  @doc "Send input to a javascript prompt()"
  def input_into_prompt(session_id, input)

  @doc "Accept javascript dialog"
  def accept_dialog(session_id)

  @doc "Dismiss javascript dialog"
  def dismiss_dialog(session_id)

end