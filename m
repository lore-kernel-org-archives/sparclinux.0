From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 14 Apr 2019 07:21:32 +0000
Subject: Naming inconsistency for serial device on sparc
Message-Id: <4c392da4-8291-fe26-fb38-22535872f127@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello!

We recently ran into a regression in the debian-installer on
sparc64 which made the serial console unusable during installation.

It turned out that the regression was introduced by a change in
the rootskel package [1] and the problem is that "steal-tty" is
not able to find the active serial console and pick it up for
the installer.

After looking at the code changes, we found out that the problem is
that in the sparc64 kernel, the device names for the serial console
in /proc/consoles does not match the one under /sys:

root@landau:~# cat /proc/consoles=20
ttyHV0               -W- (EC p  )    4:64
tty0                 -WU (E     )    4:1
root@landau:~#

root@landau:~# readlink /sys/dev/char/4:64
../../devices/root/f0299a70/f029b788/tty/ttyS0
root@landau:~#

Thus, any software reading /proc/consoles will not be able to figure
out what the name of the serial device is.

Is there any particular reason this device name mismatch exists or
is it just a bug we can fix?

Thanks,
Adrian

> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=926539
> [2] https://salsa.debian.org/installer-team/rootskel/commit/b6048aafed7d7=
3ba42da04d6f7a798710f271384#11da32c570b25101c7d830e4fd6c254c323cddc8_21_16

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
