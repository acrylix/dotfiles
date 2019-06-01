{ pkgs, ...}:

{
  enable = true;
  settings = {
    global = {
      geometry = "500x80-30+30";
      transparency = 50;
      separator_height = 0;
      separator_color = "auto";
      notification_height = 20;
      padding = 30;
      corner_radius = 10;
      horizontal_padding = 20;
      font = "Fira Code 10";
      format = "<b>%s</b>\n%b";
      word_wrap = true;
      markup = "full";

      icon_position = "left";
      max_icon_size = 60;
      frame_color ="#B8F5CD";
      frame_width = 2;
    };
    urgency_low = {
      background = "#2d3436";
      foreground = "#B8F5CD";
      timeout = 5;
      icon = "";
    };
    urgency_normal = {
      background = "#2d3436";
      foreground = "#B8F5CD";
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