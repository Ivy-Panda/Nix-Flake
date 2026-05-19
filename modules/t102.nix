{ config, pkgs, lib, ... }: {

 # Tandy T102 / Model-T  Terminal Connection Module

 # NOTE: The Tandy T102 and the TRS-80 m100 have the same TELCOM program so names may be used interchangably
 # NOTE: If you are using a Model T that is not m100 compatible (such as the td200) make sure to change all instances of "m100" to the correct terminfo

 # TODO: make service run automatically if /dev/ttyUSB0 exists

 # Make sure to change "ttyUSB0" to whichever /dev/tty you will be connecting
 systemd.services."serial-getty@ttyUSB0" = {

   # This is used so Nix will correctly find our new service file
   overrideStrategy = "asDropin";

   serviceConfig = {

     # FIXME: change run paths to nix input variable
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

 # Inputrc (readline) settings for T102 in configuration.nix because nix doesn't like double-setting environment.etc."inputrc".text

 # Stty settings are inherited by interactiveShellInit

 # Stty values = speed 19200 baud; rows 0; columns 0; line = 0;intr = ^C; quit = <undef>; erase = ^H; kill = <undef>; eof = ^Z; eol = <undef>;eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = <undef>;rprnt = <undef>; werase = <undef>; lnext = ^V; discard = ^O; min = 1; time = 0;-parenb -parodd -cmspar cs8 hupcl -cstopb cread clocal -crtscts-ignbrk brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon ixoff-iuclc -ixany -imaxbel -iutf8opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0isig icanon iexten echo echoe echok echonl -noflsh -xcase -tostop -echoprt -echoctl echoke -flusho -extproc

 programs.bash.shellInit = ''

   if [ "$TERM" = m100 ]; then

   stty -F /dev/ttyUSB0 1502:5:cbe:887b:3:0:8:0:1a:0:1:0:11:13:0:0:0:f:0:16:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0

   PS1='\$ '

   MANWIDTH=40
   # Less has issues on this terminal
   MANPAGER=more
   # Removes formatting from man
   GROFF_NO_SGR=1

   COLORTERM=""
   NO_COLOR=1

   # Testing value
   LESSANSIENDCHARS=pq

   alias git="git -c color.ui=never"

   fi
 '';

 # This is needed to stop nix default /etc/bashrc from setting PS1 line in a stupid way, make sure to use lib.mkAfter
 # TODO: Send pull request to make PS1 checks better than "if TERM != dumb and not in emacs, set fancy PS1"
 # FIXME: move PS1 into programs.bash.promptInit
 programs.bash.interactiveShellInit = lib.mkAfter ''

   if [ "$TERM" = m100 ]; then

   echo

   PS1='\$ '

   PAGER=more

   fi
 '';
}
