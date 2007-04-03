From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 03 Apr 2007 05:12:51 +0000
Subject: [ANNOUNCE] Aurora SPARC Linux Build 2.98 (Beta 1 for 3.0)
Message-Id: <1175577171.3531.131.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The Aurora SPARC Linux project is proud to finally present Build 2.98 to
the world.

This is a BETA release, for what will become 3.0. Here are some of the
key features in this release:

- Fedora Core 6 based tree of packages (some things are newer)
- Support for Niagara hardware (Sun T1000, T2000)
- gcc-4.1.1
- gnome 2.16
- KDE 3.5.5
- kernel 2.6.20 (with patches!)
- Full support for LVM at installtime (no more crashes!)

Like all BETAs, this one has some bugs. Here are the ones we know about:

- CDROM installs on sparc32 hardware don't work. If you're installing to
a sparc32 system, netboot.
- Smartd seems to make systems using the esp.ko SCSI driver very very
unhappy. If your system is esp based, we highly recommend that you
disable the smartd service in single-user before fully booting after
install.
- cpuspeed seems to hardlock some sparc64 systems (the V120 is an
example). Again, if your system locks up at cpuspeed, we suggest that
you disable the cpuspeed service in single-user mode.
- Parted was doing incorrect things in previous Aurora releases. This is
the source of the odd cylinder-head error messages that have popped up
in the past. Sometimes these error messages are harmless, sometimes they
are not. Either way, you can get rid of them by booting to rescue mode,
then, at the shell prompt, run:

dd if=/dev/zero of=/dev/$DRIVE bs=1M count=1

Where $DRIVE is your harddrive, likely sda or hda.

Then, reinstall. The errors will vanish (for good!). Be aware that
running this command will wipe out all the data and partitions on that
disk.

- E10000 systems are not yet supported. :/
- Some headless serial installs are not getting the proper getty entries
added to have a serial console. If this happens to you, please let us
know, as we're not really sure why this is happening (it doesn't happen
on all systems in testing).
- Most IDE based SPARC systems need to boot with ide=nodma.
Specifically, Ultra 5/10 and Sun Blade 100s need this for sure.
- While all apps are compiled with support for SELinux, it is disabled
in both sparc32 and sparc64 kernels, because it doesn't work right. At
all. It prevents the system from booting. 

If you find other bugs, please report them at
http://bugzilla.auroralinux.org/

If you install 2.98 on a system, success or fail, we wanna know! Please
take a moment and add your system to the table on our wiki:
http://wiki.auroralinux.net/wiki/Build2.98TestMatrix

You can download the files from our primary location:
ftp://ibiblio.org/pub/linux/distributions/aurora/build-2.98
http://distro.ibiblio.org/pub/linux/distributions/aurora/build-2.98/

The mirror sites should pick it up in a few hours/days, depending on
whether they still remember that we exist. :)

Many thanks to the folks in #aurora on freenode for their help in
getting this release out, and a special thanks to Dennis Gilmore for all
of the infrastructure work that made this release possible.

~spot


