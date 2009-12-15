#!/usr/bin/env perl
use strict;
use warnings;
use 5.010_000;

# zshscript is -terrible-. My last prompt file didn't have -nearly-
# enough of what I wanted to do with my prompt, because it was getting
# hideous and anything would end up breaking anything else.

# This perl script doesn't have access to zsh, so some things aren't
# there (most notably hashed directories), but it does the job a lot
# better than the old... thing did.

# Anyway, philosophy. I like my prompt two lines big, which is
# alright, as I can display 62 lines at once on this screen. It's a
# lot nicer than having info at the right hand side of the prompt,
# which was usually too far away, all the info is in the same place,
# and it's not irritating to paste to anybody.

my $red    = "%{\033[31m%}";
my $green  = "%{\033[32m%}";
my $yellow = "%{\033[33m%}";
my $blue   = "%{\033[34m%}";
my $cyan   = "%{\033[36m%}";
my $purple = "%{\033[35m%}";
my $lgrey  = "%{\033[37m%}";
my $back   = "%{\033[0m%}";

my $black   = "%{\033[0;30m%}";
my $dgrey   = "%{\033[1;30m%}";
my $bblue   = "%{\033[1;34m%}";
my $bgreen  = "%{\033[1;32m%}";
my $bcyan   = "%{\033[1;36m%}";
my $bred    = "%{\033[1;31m%}";
my $bpurple = "%{\033[1;35m%}";
my $byellow = "%{\033[1;33m%}";
my $white   = "%{\033[1;37m%}";

### user and hostname

my %hostnames = (
  Dostoyevsky => "%{\033]1;33m%}",    # desktop
);

### user

my $user = $ENV{USER};
my $pwd  = $ENV{PWD};
chomp( my $host = `hostname` );

my $colour = $hostnames{$host} || "%{\033[31m%}";
my $whoami = "$back $white\@$back $yellow$host$back";

### date

#                               +'%H:%M'
chomp( my $time = `date +'%H:%M:%S:%N'` );
chomp( my $date = `date +'%y:%m:%d'` );

### pwd

my $real_pwd = $pwd;

$pwd =~ s#^/(?:Users|home|vault/home)/([^/]+)#
  ($user eq $1) ? "~" : "~$1"
  #xe;

# Look up the pwd in the mounts list
sub media_dir {
  my $mp = shift;
  $mp =~ s/\s/\\040/g;

  open my $proc_mounts, q[<], q[/proc/mounts];
  my @mounts = grep { m[/media/$mp] } <$proc_mounts>;
  close $proc_mounts;
  my ($dev, $dir, $fs) = split /\s/, (shift @mounts or return "$green/media/$mp");

  given ($fs) {
    when (/sshfs/) {
      return "%{$yellow%}\[ssh:" . (split ':', $dev)[0] . "]";
    }
    when (/cifs/) {
      return "%{$yellow%}\[smb:" . (split ':', $dev)[0] . "]";
    }
    default {
      return "%{$yellow%}\[$dir]";
    }
  }
}

# Colour it all in green
sub colour_pwd {
  my $dir = shift;
  $dir =~ s!
	     ((?:/[^/]+)*)	# parent directories
	     /([^/]+)		# current directory
	   !\%{\033[0;32m\%}$1/\%{\033[1;32m\%}$2!x;
  return "\%{\033[1;32m\%}$dir";
}

# Collapse lower dirs into one character when necessary
sub collapse {
  my $dir = shift;
  chomp( my $cols = `tput cols` );
  if (length $dir > $cols - 50) {
    $dir =~ s#([^/][^/]+?)/#fall($1) . '/'#ge or last;
  }
  return $dir;
}

sub fall {
  my $fn = shift;
  my @bits = split /\s+/, $fn;
  @bits = map { s/(\S)\S*\s*/$1/g; $_ } @bits;
  return join '', @bits;
}

if ($pwd =~ m#^/media/([^/]+)/?(.*)#) {
  $pwd = media_dir($1) . colour_pwd("/" . collapse($2));
} else {
  $pwd = colour_pwd(collapse($pwd));
}

### version control

sub vc {
  return "" if $real_pwd =~ m#^/etc#;
  if ( -d "_darcs" ) {
    my $d = "d";
    $d .= "*" if `darcs whatsnew` !~ /^No changes/;
    return " ($d)";
  }
  elsif ( -d ".git" ) {
    my $status = `git status`;
    my $g = "g";
    $g .= "[*]" if $status !~ /nothing to commit/;
    $g .= ":$1" if $status =~ /On branch (.*)/;
    $g =~ s/[\*]:/*/;
    return " ($g)";
  }
  else {
    return "";
  }
}

my $vc = vc;

#                         user$whomai
print "$cyan%{%}q%{%}[$bpurple$user $bred($white$date$bred|$white$time$bred) $pwd%{\033[0m%}$green$vc$bblue >$back\n"
  .   "$back";
