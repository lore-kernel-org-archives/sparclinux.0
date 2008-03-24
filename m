From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Mon, 24 Mar 2008 22:03:35 +0000
Subject: Re: build breakage on sparc64 due to commit 54cd6dde
Message-Id: <200803242303.35840.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <200803242053.22709.m.kozlowski@tuxland.pl>
In-Reply-To: <200803242053.22709.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

> From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> Date: Mon, 24 Mar 2008 20:53:22 +0100
> 
> > 	I get this error when building latest Linus git (and 2.6.25-rc5-mm1) tree:
> > 
> > arch/sparc64/kernel/asm-offsets.c:1: error: -m64 is not supported by this configuration
> > arch/sparc64/kernel/asm-offsets.c:1: error: -mlong-double-64 not allowed with -m64
> > arch/sparc64/kernel/asm-offsets.c:1: error: -mcmodel= is not supported on 32 bit systems
> > make[1]: *** [arch/sparc64/kernel/asm-offsets.s] Error 1
> 
> Are you cross-compiling?

No.
 
> If not, what kind of system is this?
 
It is mostly 'stable' version of gentoo. That means only a few packages use ~sparc flag and those
packages are not related to the problem. The only thing I really play with on this box is testing
various kernel trees and versions. Actually I have two versions of gcc installed and I can switch
between them. One is 4.1.2 and second is 3.4.6. Both return the same build error.

$ gcc-config -l
 [1] sparc-unknown-linux-gnu-3.4.6
 [2] sparc-unknown-linux-gnu-3.4.6-hardened
 [3] sparc-unknown-linux-gnu-3.4.6-hardenednopie
 [4] sparc-unknown-linux-gnu-3.4.6-hardenednopiessp
 [5] sparc-unknown-linux-gnu-3.4.6-hardenednossp
 [6] sparc-unknown-linux-gnu-4.1.2 *
 [7] sparc64-unknown-linux-gnu-4.1.2 *

$ gcc -v
Using built-in specs.
Target: sparc-unknown-linux-gnu
Configured with: /var/tmp/portage/sys-devel/gcc-4.1.2/work/gcc-4.1.2/configure --prefix=/usr
--bindir=/usr/sparc-unknown-linux-gnu/gcc-bin/4.1.2 --includedir=/usr/lib/gcc/sparc-unknown-linux-gnu/4.1.2/include
--datadir=/usr/share/gcc-data/sparc-unknown-linux-gnu/4.1.2 --mandir=/usr/share/gcc-data/sparc-unknown-linux-gnu/4.1.2/man
--infodir=/usr/share/gcc-data/sparc-unknown-linux-gnu/4.1.2/info
--with-gxx-include-dir=/usr/lib/gcc/sparc-unknown-linux-gnu/4.1.2/include/g++-v4 --host=sparc-unknown-linux-gnu
--build=sparc-unknown-linux-gnu --disable-altivec --disable-nls --with-system-zlib --disable-checking --disable-werror
--enable-secureplt --disable-libunwind-exceptions --disable-multilib --enable-libmudflap --disable-libssp --disable-libgcj
--enable-languages=c,c++,treelang,fortran --enable-shared --enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu
Thread model: posix
gcc version 4.1.2 (Gentoo 4.1.2 p1.0.2)

$ gcc -v
Reading specs from /usr/lib/gcc/sparc-unknown-linux-gnu/3.4.6/specs
Configured with: /var/tmp/portage/sys-devel/gcc-3.4.6-r2/work/gcc-3.4.6/configure --prefix=/usr
--bindir=/usr/sparc-unknown-linux-gnu/gcc-bin/3.4.6 --includedir=/usr/lib/gcc/sparc-unknown-linux-gnu/3.4.6/include
--datadir=/usr/share/gcc-data/sparc-unknown-linux-gnu/3.4.6 --mandir=/usr/share/gcc-data/sparc-unknown-linux-gnu/3.4.6/man
--infodir=/usr/share/gcc-data/sparc-unknown-linux-gnu/3.4.6/info
--with-gxx-include-dir=/usr/lib/gcc/sparc-unknown-linux-gnu/3.4.6/include/g++-v3 --host=sparc-unknown-linux-gnu
--build=sparc-unknown-linux-gnu --disable-altivec --disable-nls --with-system-zlib --disable-checking --disable-werror
--enable-secureplt --disable-libunwind-exceptions --disable-multilib --disable-libgcj --enable-languages=c,c++,treelang
--enable-shared --enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu
Thread model: posix
gcc version 3.4.6 (Gentoo 3.4.6-r2 p1.5, ssp-3.4.6-1.0, pie-8.7.10)

$ emerge --info
Portage 2.1.4.4 (default-linux/sparc/sparc64/2007.0, gcc-4.1.2, glibc-2.6.1-r0, 2.6.24 sparc64)
================================System uname: 2.6.24 sparc64 sun4u
Timestamp of tree: Sat, 22 Mar 2008 16:30:03 +0000
app-shells/bash:     3.2_p17-r1
dev-lang/python:     2.4.4-r6
dev-python/pycrypto: 2.0.1-r6
sys-apps/baselayout: 1.12.11.1
sys-apps/sandbox:    1.2.18.1-r2
sys-devel/autoconf:  2.61-r1
sys-devel/automake:  1.9.6-r2, 1.10
sys-devel/binutils:  2.18-r1
sys-devel/gcc-config: 1.3.14
sys-devel/libtool:   1.5.26
virtual/os-headers:  2.6.23-r3
ACCEPT_KEYWORDS="sparc"
CBUILD="sparc-unknown-linux-gnu"
CFLAGS="-O2 -mcpu=ultrasparc -pipe"
CHOST="sparc-unknown-linux-gnu"
CONFIG_PROTECT="/etc"
CONFIG_PROTECT_MASK="/etc/env.d /etc/gconf /etc/revdep-rebuild /etc/terminfo /etc/udev/rules.d"
CXXFLAGS="-O2 -mcpu=ultrasparc -pipe"
DISTDIR="/usr/portage/distfiles"
FEATURES="distlocks metadata-transfer sandbox sfperms strict unmerge-orphans userfetch"
GENTOO_MIRRORS="http://distfiles.gentoo.org http://distro.ibiblio.org/pub/linux/distributions/gentoo"
MAKEOPTS="-j3"
PKGDIR="/usr/portage/packages"
PORTAGE_RSYNC_OPTS="--recursive --links --safe-links --perms --times --compress --force --whole-file
--delete --stats --timeout0 --exclude=/distfiles --exclude=/local --exclude=/packages"
PORTAGE_TMPDIR="/var/tmp"
PORTDIR="/usr/portage"
SYNC="rsync://rsync.gentoo.org/gentoo-portage"
USE="cli cracklib cups dri gdbm iconv isdnlog midi mudflap ncurses nptl nptlonly openmp
pcre ppds pppd reflection session slang sparc spl unicode xorg" ALSA_PCM_PLUGINS="adpcm
alaw asym copy dmix dshare dsnoop empty extplug file hooks iec958 ioplug ladspa lfloat
linear meter mulaw multi null plug rate route share shm softvol"
APACHE2_MODULES="actions alias auth_basic authn_alias authn_anon authn_dbm authn_default
authn_file authz_dbm authz_default authz_groupfile authz_host authz_owner authz_user autoindex
cache dav dav_fs dav_lock deflate dir disk_cache env expires ext_filter file_cache filter
headers include info log_config logio mem_cache mime mime_magic negotiation rewrite setenvif
speling status unique_id userdir usertrack vhost_alias"
ELIBC="glibc"
INPUT_DEVICES="keyboard mouse evdev"
KERNEL="linux"
LCD_DEVICES="bayrad cfontz cfontz633 glk hd44780 lb216 lcdm001 mtxorb ncurses text"
USERLAND="GNU"
Unset:  CPPFLAGS, CTARGET, EMERGE_DEFAULT_OPTS, INSTALL_MASK, LANG, LC_ALL, LDFLAGS, LINGUAS,
PORTAGE_COMPRESS, PORTAGE_COMPRESS_FLAGS, PORTAGE_RSYNC_EXTRA_OPTS, PORTDIR_OVERLAY
