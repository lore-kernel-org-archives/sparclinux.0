From: Meelis Roos <mroos@linux.ee>
Date: Fri, 14 Jul 2017 08:45:23 +0000
Subject: Trying out debian sparc64
Message-Id: <alpine.LRH.2.20.1707141131580.3086@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Did you also perform tests with a current 64-bit userland?

I got my next machine, T5140, and decided to give sparc64 debian port a 
go. Here is my timeline of experiences.

* There is still no netboot installer - this limits my testing since not 
  all machines have a CD/DVD drive and my standard install here is 
  connect the cables, leave the cold room and do everything over the 
  network. The T5140 had a DVD driver fortunately, so I wrote a netinst 
  CD from 2017-03-24 and used that.

* The CD boots fine. Top of installer screen hints there is something 
  similar to virtual consoles but here is no hint how to use them on 
  serial console (if possible at all).

* Network setup is fine.

* Installer does not create separate /boot any more, good!

* Installer still tells ext4 is unsupported for silo, that should not be 
  a problem for years now?

* Initial debootstrap is fine.

* Installer asks for mirror and there is no good information on the 
wiki. I derived host = deb.debian.org and directory = /debian-ports and 
it started downloading so seems correct.

* Package selection failed. Relevant part of the syslog:

Jul 14 07:35:34 pkgsel: checking for (security) updates to the base system
Jul 14 07:35:36 in-target: Reading package lists...
Jul 14 07:35:47 in-target:
Jul 14 07:35:48 in-target: Building dependency tree...
Jul 14 07:35:49 in-target:
Jul 14 07:35:49 in-target: Reading state information...
Jul 14 07:35:49 in-target:
Jul 14 07:35:49 in-target: Calculating upgrade...
Jul 14 07:35:50 in-target:
Jul 14 07:35:52 in-target: The following packages have been kept back:
Jul 14 07:35:52 in-target:   gcc-6-base libgcc1 libgnutls30 libidn2-0 libpsl5 libstdc++6
Jul 14 07:35:52 in-target:   linux-image-sparc64-smp
Jul 14 07:35:52 in-target: The following packages will be upgraded:
Jul 14 07:35:52 in-target:   apt apt-utils base-files bash bsdmainutils bsdutils dash debconf
Jul 14 07:35:52 in-target:   debconf-i18n debian-archive-keyring debianutils dmsetup dpkg eject findutils
Jul 14 07:35:52 in-target:   gcc-5-base gnupg gnupg-agent gpgv grep init init-system-helpers
Jul 14 07:35:52 in-target:   initramfs-tools initramfs-tools-core iptables libapparmor1 libapt-inst2.0
Jul 14 07:35:52 in-target:   libapt-pkg5.0 libaudit-common libaudit1 libblkid1 libbsd0 libc-bin libc-l10n
Jul 14 07:35:52 in-target:   libc6 libcryptsetup4 libdb5.3 libdebconfclient0 libdevmapper1.02.1
Jul 14 07:35:52 in-target:   libdns-export162 libelf1 libfastjson4 libfdisk1 libgcrypt20 libgpg-error0
Jul 14 07:35:52 in-target:   libip4tc0 libip6tc0 libiptc0 libisc-export160 liblognorm5 liblzma5 libmount1
Jul 14 07:35:52 in-target:   libncurses5 libncursesw5 libnewt0.52 libnpth0 libp11-kit0 libpam-modules
Jul 14 07:35:52 in-target:   libpam-modules-bin libpam-runtime libpam0g libpipeline1 libreadline7
Jul 14 07:35:52 in-target:   libselinux1 libsemanage1 libsmartcols1 libsqlite3-0 libssl1.0.2 libssl1.1
Jul 14 07:35:52 in-target:   libsystemd0 libtasn1-6 libtinfo5 libudev1 libusb-1.0-0 libuuid1 libxapian30
Jul 14 07:35:52 in-target:   libxtables12 locales login mount multiarch-support nano ncurses-base
Jul 14 07:35:52 in-target:   ncurses-bin passwd perl-base readline-common rsyslog sensible-utils systemd
Jul 14 07:35:52 in-target:   systemd-sysv tzdata udev util-linux vim-common vim-tiny wget whiptail xxd
Jul 14 07:35:52 in-target: 99 upgraded, 0 newly installed, 0 to remove and 7 not upgraded.
Jul 14 07:35:52 in-target: Need to get 38.8 MB of archives.
Jul 14 07:35:52 in-target: After this operation, 1,684 kB of additional disk space will be used.
Jul 14 07:35:52 in-target: WARNING: The following packages cannot be authenticated!
Jul 14 07:35:52 in-target:   base-files sensible-utils debianutils bash libc6 libbsd0 libncurses5
Jul 14 07:35:52 in-target:   libtinfo5 libncursesw5 bsdmainutils bsdutils dpkg dash findutils grep login
Jul 14 07:35:52 in-target:   util-linux mount ncurses-bin perl-base init-system-helpers libc-bin
Jul 14 07:35:52 in-target:   ncurses-base liblzma5 libapt-pkg5.0 libapt-inst2.0 libdb5.3
Jul 14 07:35:52 in-target:   debian-archive-keyring apt apt-utils libgpg-error0 libgcrypt20 gpgv
Jul 14 07:35:52 in-target:   debconf-i18n debconf libaudit-common libaudit1 libpam0g libselinux1
Jul 14 07:35:52 in-target:   libpam-modules-bin libpam-modules libsystemd0 systemd udev libudev1 libuuid1
Jul 14 07:35:52 in-target:   libblkid1 libapparmor1 dmsetup libdevmapper1.02.1 libcryptsetup4
Jul 14 07:35:52 in-target:   libxtables12 iptables libip6tc0 libiptc0 libip4tc0 libmount1 init
Jul 14 07:35:52 in-target:   initramfs-tools initramfs-tools-core systemd-sysv libfdisk1 libpam-runtime
Jul 14 07:35:52 in-target:   libsmartcols1 multiarch-support libsemanage1 passwd libp11-kit0 libtasn1-6
Jul 14 07:35:52 in-target:   libdebconfclient0 gcc-5-base tzdata libnpth0 readline-common libreadline7
Jul 14 07:35:52 in-target:   gnupg gnupg-agent libsqlite3-0 libnewt0.52 libpipeline1 libssl1.0.2
Jul 14 07:35:52 in-target:   libssl1.1 libxapian30 nano libfastjson4 liblognorm5 rsyslog xxd vim-tiny
Jul 14 07:35:52 in-target:   vim-common wget whiptail libc-l10n locales eject libisc-export160
Jul 14 07:35:52 in-target:   libdns-export162 libelf1 libusb-1.0-0
Jul 14 07:35:52 in-target: E
Jul 14 07:35:52 in-target: : 
Jul 14 07:35:52 in-target: There were unauthenticated packages and -y was used without --allow-unauthenticated
Jul 14 07:35:52 in-target: 
Jul 14 07:35:55 kernel: [63192.033713] ISO 9660 Extensions: RRIP_1991A
Jul 14 07:35:58 main-menu[229]: WARNING **: Configuring 'pkgsel' failed with error code 100
Jul 14 07:35:58 main-menu[229]: WARNING **: Menu item 'pkgsel' failed.

So it seems the installer does not have relevant PGP key for this repo.

Am I using wrong repo? Should I add some PGP key manually? Or is the 
March installer out of date with respect to current PGP keys after 
stretch was released?

-- 
Meelis Roos (mroos@linux.ee)
