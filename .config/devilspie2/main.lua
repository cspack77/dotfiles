-- the debug_print command does only print anything to stdout
-- if devilspie2 is run using the --debug option
debug_print("Window Name: " .. get_window_name());
debug_print("Application name: " .. get_application_name())
debug_print("Window Class: " .. get_window_class())
debug_print("Window Type: " .. get_window_type())

-- mpv geometry
if (get_window_class() == "mpv") then
  -- xpos,ypos,xsize,ysize
  set_window_geometry (0, 0, 1720, 965)
end

-- Make these windows visible on all workspaces
if (get_window_class() == "Hexchat" and get_window_type() == "WINDOW_TYPE_NORMAL") then
  set_window_geometry2(2520, 0, 1320, 810)
  stick_window()
end

if (get_window_class() == "chatty-Chatty" and get_window_type() == "WINDOW_TYPE_NORMAL") then
  set_window_geometry2(1920, 0, 600, 810)
  stick_window()
end
