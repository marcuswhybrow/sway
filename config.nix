{ pkgs, assets, inputs, ... }: let 
  alacritty = "${inputs.alacritty.packages.x86_64-linux.alacritty}/bin/alacritty";
  private = "${inputs.private.packages.x86_64-linux.private}/bin/private";
  logout = "${inputs.logout.packages.x86_64-linux.logout}/bin/logout";
  rofi = "${inputs.rofi.packages.x86_64-linux.rofi}/bin/rofi";
  volume = "${inputs.volume.packages.x86_64-linux.volume}/bin/volume";
  brightness = "${inputs.brightness.packages.x86_64-linux.brightness}/bin/brightness";
  waybar = "${inputs.waybar.packages.x86_64-linux.waybar}/bin/waybar";
  firefox = "${pkgs.firefox}/bin/firefox";
  grimshot = "${pkgs.sway-contrib.grimshot}/bin/grimshot";
  gsound-play = "${pkgs.gsound}/bin/gsound-play";
  dbus-update-activation-environment = "${pkgs.dbus}/bin/dbus-update-activation-environment";
  swaynag = "${pkgs.sway}/bin/swaynag";
in ''
  font pango:monospace 8.000000

  floating_modifier Mod1

  default_border pixel 2
  default_floating_border pixel 2
  hide_edge_borders none

  focus_wrapping no
  focus_follows_mouse yes
  focus_on_window_activation smart

  mouse_warping output

  workspace_layout default
  workspace_auto_back_and_forth no

  client.focused #ff0000 #ff0000 #000000 #ff0000 #ff441e
  client.focused_inactive #ffffff #ffffff #000000 #0000ff #ffffff00
  client.unfocused #ffffff #ffffff #000000 #00ff00 #dddddd
  client.urgent #2f343a #900000 #ffffff #900000 #900000
  client.placeholder #000000 #0c0c0c #ffffff #000000 #0c0c0c
  client.background #ffffff

  bindsym Mod1+1 workspace number 1
  bindsym Mod1+2 workspace number 2
  bindsym Mod1+3 workspace number 3
  bindsym Mod1+4 workspace number 4
  bindsym Mod1+5 workspace number 5
  bindsym Mod1+6 workspace number 6
  bindsym Mod1+7 workspace number 7
  bindsym Mod1+8 workspace number 8
  bindsym Mod1+9 workspace number 9

  bindsym Mod1+Shift+1 move container to workspace number 1
  bindsym Mod1+Shift+2 move container to workspace number 2
  bindsym Mod1+Shift+3 move container to workspace number 3
  bindsym Mod1+Shift+4 move container to workspace number 4
  bindsym Mod1+Shift+5 move container to workspace number 5
  bindsym Mod1+Shift+6 move container to workspace number 6
  bindsym Mod1+Shift+7 move container to workspace number 7
  bindsym Mod1+Shift+8 move container to workspace number 8
  bindsym Mod1+Shift+9 move container to workspace number 9

  bindsym Mod1+Shift+minus move scratchpad
  bindsym Mod1+minus scratchpad show

  bindsym Mod1+h focus left
  bindsym Mod1+j focus down
  bindsym Mod1+k focus up
  bindsym Mod1+l focus right

  bindsym Mod1+Shift+h move left
  bindsym Mod1+Shift+j move down
  bindsym Mod1+Shift+k move up
  bindsym Mod1+Shift+l move right

  bindsym Mod1+Return exec ${alacritty}
  bindsym Mod1+Shift+Return exec ${private}
  bindsym Mod1+Escape exec ${logout}
  bindsym Mod1+d exec ${rofi} -show drun -i -drun-display-format {name} -theme-str 'entry { placeholder: "Launch"; }' 
  bindsym Mod1+Shift+e exec ${swaynag} -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'

  bindsym Mod1+Shift+c reload
  bindsym Mod1+Shift+q kill

  bindsym Mod1+Shift+space floating toggle

  bindsym Mod1+a focus parent
  bindsym Mod1+space focus mode_toggle

  bindsym Mod1+v splitv
  bindsym Mod1+b splith

  bindsym Mod1+e layout toggle split
  bindsym Mod1+f fullscreen toggle

  bindsym Mod1+r mode resize

  bindsym Mod1+s layout stacking
  bindsym Mod1+w layout tabbed

  bindsym Mod4+B exec ${firefox}
  bindsym Mod4+D exec "${alacritty} --working-directory ~/.dotfiles --command vim .
  bindsym Print exec "${grimshot} save output & ${gsound-play} -f ${assets}/sounds/screenshot.wav"

  bindsym XF86AudioLowerVolume exec ${volume} down
  bindsym XF86AudioMute exec ${volume} toggle-mute
  bindsym XF86AudioRaiseVolume exec ${volume} up
  bindsym XF86MonBrightnessDown exec ${brightness} down
  bindsym XF86MonBrightnessUp exec ${brightness} up

  input "*" {
    natural_scroll enabled
    repeat_delay 300
    tap enabled
    xkb_layout gb
  }

  output "*" {
    background ${assets}/wallpapers/inkwater.jpg fill
  }

  mode "resize" {
    bindsym Down resize grow height 10 px
    bindsym Escape mode default
    bindsym Left resize shrink width 10 px
    bindsym Return mode default
    bindsym Right resize grow width 10 px
    bindsym Up resize shrink height 10 px
    bindsym h resize shrink width 10 px
    bindsym j resize grow height 10 px
    bindsym k resize shrink height 10 px
    bindsym l resize grow width 10 px
  }

  gaps top 20
  gaps outer 10
  gaps inner 10

  bar {
    swaybar_command ${waybar}
  }
  
  exec "${dbus-update-activation-environment} DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP XDG_SESSION_TYPE; systemctl --user start sway-session.target"
''
