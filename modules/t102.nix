{ config, pkgs, ... }: {

 # Tandy T102 Terminal Connection Module

 # Make sure to change "ttyUSB0" to whichever /dev/tty you will be connecting
 systemd.services."serial-getty@ttyUSB0" = {

   # This is used so Nix will correctly find our new service file
   overrideStrategy = "asDropin";

   serviceConfig = {

     ExecStart = [
       ""
       "/run/current-system/sw/bin/agetty -8 -o '-p -- \\u' --noissue --local-line --login-program /run/current-system/sw/bin/login --keep-baud 19200 %I m100"
     ];
     TTYReset = "no";
     TTYVHangup = "no";
     TTYColumns = "40";
     TTYRows = "8";
     };
   };
 }
