{ pkgs, ...}:
{
  enable = true;
  hooks.postswitch = {
    i3-restart = "i3-msg restart && wal -i ~/Pictures/wal/cyberpunk";
  };
  profiles = {
    "home" = {
      fingerprint = {
        DP1 = "00ffffffffffff001e6d077721750100071c0104b53c22789e3e31ae5047ac270c50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00383d1e8738000a202020202020000000fc004c472048445220344b0a20202001d20203197144900403012309070783010000e305c000e3060501023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000029";
        eDP1 = "00ffffffffffff0006af362000000000001b0104a51f117802fbd5a65334b6250e505400000001010101010101010101010101010101e65f00a0a0a040503020350035ae100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343051414e30322e30200a00d2";
      };
      config = {
        eDP1 = {
          enable = true;
          primary = true;
          mode = "2560x1440";
          position = "688x2160";
          rate = "60.01";
        };
        DP1 = {
          enable = true;
          mode = "3840x2160";
          position = "0x0";
          rate = "60.00";
        };
      };
    };
    "horizon" = {
      fingerprint = {
        DP1 = "00ffffffffffff001e6d0777e0a70500091d0104b53c22789e3e31ae5047ac270c50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00383d1e8738000a202020202020000000fc004c472048445220344b0a20202001da0203197144900403012309070783010000e305c000e3060501023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000029";
        eDP1 = "00ffffffffffff0006af362000000000001b0104a51f117802fbd5a65334b6250e505400000001010101010101010101010101010101e65f00a0a0a040503020350035ae100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343051414e30322e30200a00d2";
      };
      config = {
        eDP1 = {
          enable = true;
          primary = true;
          mode = "2560x1440";
          position = "580x2160";
          rate = "60.01";
        };
        DP1 = {
          enable = true;
          mode = "3840x2160";
          position = "0x0";
          rate = "60.00";
        };
      };
    };
    "default" = {
      fingerprint.eDP1 = "00ffffffffffff0006af362000000000001b0104a51f117802fbd5a65334b6250e505400000001010101010101010101010101010101e65f00a0a0a040503020350035ae100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343051414e30322e30200a00d2";
      config.eDP1 = {
        enable = true;
        primary = true;
        mode = "2560x1440";
        position = "0x0";
        rate = "60.01";
      };
    };
  };
}

