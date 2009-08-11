# New, brighter, whiter version of my autoaway script. Actually works :)

use Irssi;
use Irssi::Irc;

use vars qw($VERSION %IRSSI);
$version = "0.2";
%IRSSI = (
    authors => 'Larry "Vizzie" Daffner',
    contact => 'vizzie@airmail.net',
    name => 'Automagic away setting',
    description => 'Automatically goes  away after defined inactivity',
    licence => 'BSD',
    url => 'http://www.flamingpackets.net/~vizzie/irssi/',
    changed => 'Wed Mar 13 00:48:39 CST 2002',
    changes => '+cleanup'
);

my ($autoaway_sec, $autoaway_to_tag, $autoaway_state);
$autoaway_state = 0;

#
# /AUTOAWAY - set the autoaway timeout
#
sub cmd_autoaway {
  my ($data, $server, $channel) = @_;
  
  if (!($data =~ /^[0-9]+$/)) {
    Irssi::print("autoaway: usage: /autoaway <seconds>");
    return 1;
  }
  
  $autoaway_sec = $data;
  
  if ($autoaway_sec) {
    Irssi::print("autoaway timeout set to $autoaway_sec seconds");
  } else {
    Irssi::print("autoway disabled");
  }
  
  if (defined($autoaway_to_tag)) {
    Irssi::timeout_remove($autoaway_to_tag);
    $autoaway_to_tag = undef;
  }

  if ($autoaway_sec) {
    $autoaway_to_tag =
      Irssi::timeout_add($autoaway_sec*1000, "auto_timeout", "");
  }
}

#
# away = Set us away or back, within the autoaway system
sub cmd_away {
  my ($data, $server, $channel) = @_;
  
  if ($data eq "") {
    $autoaway_state = 0;
    # If $autoaway_state is 2, we went away by typing /away, and need
    # to restart autoaway ourselves. Otherwise, we were autoaway, and
    # we'll let the autoaway return take care of business.

    if ($autoaway_state eq 2) {
      if ($autoaway_sec) {
	$autoaway_to_tag =
	  Irssi::timeout_add($autoaway_sec*1000, "auto_timeout", "");
      }
    }
  } else {
    if ($autoaway_state eq 0) {
      Irssi::timeout_remove($autoaway_to_tag);
      $autoaway_to_tag = undef;
      $autoaway_state = 2;
    }
  }
}

sub auto_timeout {
  my ($data, $server) = @_;
  my (@servers) = Irssi::servers();

  # we're in the process.. don't touch anything.
  $autoaway_state = 3;
  $server = $servers[0];
  $server->command("/AWAY autoaway after $autoaway_sec seconds");

  Irssi::timeout_remove($autoaway_to_tag);
  $autoaway_state = 1;
}

sub reset_timer {
   if ($autoaway_state eq 1) {
     my (@servers) = Irssi::servers();
     
     $autoaway_state = 3;
     $server = $servers[0];
     $server->command("/AWAY");
     
     $autoaway_state = 0;
   } 
  if ($autoaway_state eq 0) {
    if (defined($autoaway_to_tag)) {
      Irssi::timeout_remove($autoaway_to_tag);
      $autoaway_to_tag = undef();
    }
    if ($autoaway_sec) {
      $autoaway_to_tag = Irssi::timeout_add($autoaway_sec*1000
					    , "auto_timeout", "");
    }
  }
}

Irssi::settings_add_int("misc", "autoaway_timeout", 0);

$autoaway_default = Irssi::settings_get_int("autoaway_timeout");
if ($autoaway_default) {
  $autoaway_to_tag =
    Irssi::timeout_add($autoaway_default*1000, "auto_timeout", "");

}

Irssi::command_bind('autoaway', 'cmd_autoaway');
Irssi::command_bind('away', 'cmd_away');
Irssi::signal_add('send command', 'reset_timer');
