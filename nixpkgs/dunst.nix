{ pkgs, ...}:

{
  enable = true;
  settings = {
    global = {
      geometry = "500x80-20+20";
      transparency = 10;
      separator_height = 10;
      padding = 20;
      horizontal_padding = 20;
      font = "Fira Code 10";
      format = "<b>%s</b>\n%b";
      word_wrap = true;
      markup = "full";

      icon_position = "left";
      max_icon_size = 48;
      frame_color ="#2c3e50";
      frame_width = 3;
    };
    urgency_low = {
      background = "#eaeaea";
      foreground = "#202020";
      timeout = 5;
      icon = "";
    };
    urgency_normal = {
      background = "#bdc3c7";
      foreground = "#2c3e50";
      timeout = 5;
      icon = "";
    };
    urgency_critical = {
      background = "#eb4d4b";
      foreground = "#202020";
      timeout = 0;
      icon = "";
    };
  };
}