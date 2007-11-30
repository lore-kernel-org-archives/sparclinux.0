From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Fri, 30 Nov 2007 20:28:55 +0000
Subject: [ANNOUNCE] Aurora SPARC Linux Build 2.99 (Beta 2 for 3.0)
Message-Id: <1196454535.3432.18.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The Aurora SPARC Linux project is proud to finally drag Build 2.99 
kicking and screaming into the light.

Took us long enough, huh? Beta 1 was in April. Barring some sort of miracle,
Aurora 3.0 will be the last sparc32 supporting release. So, if you're still
clinging to your sparc32 systems, please test this beta out. After 3.0, 
we're not even going to think about sparc32 (unless well bribed).

This is a BETA release, for what will become 3.0. In fact, we're going to 
give this release a short period of time to uncover any really nasty bugs,
and then we're going to call it 3.0.

Here are some of the key features in this release:

- Fedora Core 6 based tree of packages (some things are newer)
- Support for Niagara hardware (Sun T1000, T2000)
- gcc-4.1.1
- gnome 2.16
- KDE 3.5.5
- kernel 2.6.23.1 (with patches!)
- Full support for LVM at installtime (no more crashes!)

Like all BETAs, this one has some bugs. Here are the ones we know about:

- Installs on sparc32 hardware usually work, but they're very touchy.
If you're installing to a sparc32 system, use text mode. If it fails to find
the cdrom, try: linux expert text
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
- Most IDE based SPARC systems need to boot with ide=nodma.
Specifically, Ultra 5/10 and Sun Blade 100s need this for sure.
- Systems that boot off qlogic attached disks are not supported, because 
there is no working firmware loader in anaconda, and the qlogic driver 
needs firmware.
- The graphical installer on some sparc32 systems doesn't enable the mouse.
Post installation, the mouse works fine in X.
- We haven't spun the security updates into this yet. We'll do this before 
3.0 final.
- Upgrades from 2.98 might not work. We found more errors in how we were
handling partitions at installtime, and unfortunately, the best way to fix
them is to destroy the partition tables entirely and reinstall from scratch.

If you find other bugs, please report them at
http://bugzilla.auroralinux.org/

If you install 2.99 on a system, success or fail, we wanna know! Please
take a moment and add your system to the table on our wiki:
http://wiki.auroralinux.net/wiki/Build2.99TestMatrix

You can download the files from our primary location:
ftp://ibiblio.org/pub/linux/distributions/aurora/build-2.99
http://distro.ibiblio.org/pub/linux/distributions/aurora/build-2.99

The mirror sites should pick it up in a few hours/days, depending on
whether they still remember that we exist. :)

Many thanks to the folks in #aurora on freenode for their help in
getting this release out.

~spot

