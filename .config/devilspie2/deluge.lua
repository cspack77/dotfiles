-- the debug_print command does only print anything to stdout
-- if devilspie2 is run using the --debug option
debug_print("Window Name: " .. get_window_name());
debug_print("Application name: " .. get_application_name())
debug_print("Window Class: " .. get_window_class())

-- change to deluge workspace when focused
if (get_application_name() == "deluge") then
  -- xpos,ypos,xsize,ysize
  --set_window_geometry (0, 0, 1720, 965)
  set_window_workspace(3)
  change_workspace(3)
end
