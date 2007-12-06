From: Wes Hardin <wes.hardin@dalsemi.com>
Date: Thu, 06 Dec 2007 16:39:51 +0000
Subject: SunOS/Solaris Binary Emulation
Message-Id: <475825D7.1090209@dalsemi.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm interested in trying out the Linux kernel's SunOS and/or Solaris Binary 
Emulation but I can't find any documentation that is either recent or complete.

I have scads of Ultra60s lying around, so I loaded up Debian 4.0 on it.  I 
choose Debian over Ubuntu in this case because Ubuntu doesn't seem to support 
SPARCs as desktops, only servers.  I want to evaluate how this compares to our 
Solaris 8 desktops at some point.

manhack:/usr/gnemul/solaris/bin# cat /proc/cpuinfo
cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
prom            : OBP 3.31.0 2001/07/25 20:31
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0Bogo        : 900.58
Cpu0ClkTck      : 000000001ad33148
Cpu2Bogo        : 900.14
Cpu2ClkTck      : 000000001ad33148
MMU Type        : Spitfire
State:
CPU0:           online
CPU2:           online


It's a pretty basic load.  While not too familiar with Debian in general, 
during the install, I select the Default/Basic load + Desktop component, that 
is to say not a DNS or mail server or anything else fancy.  817 packages 
installed.

manhack:/usr/gnemul/solaris/bin# /bin/uname -a
Linux manhack 2.6.18-5-sparc64-smp #1 SMP Wed Oct 3 04:16:38 UTC 2007 sparc64 
GNU/Linux

I've copied some libraries and very basic binaries from a Solaris 8 system, 
which is also a U60, to /usr/gnemul/solaris/{original path} and loaded the 
solaris.ko kernel module.

manhack:~# lsmod|grep solaris
solaris                57880  0
manhack:~# modinfo solaris
filename: 
/lib/modules/2.6.18-5-sparc64-smp/kernel/arch/sparc64/solaris/solaris.ko
author:         Jakub Jelinek (jj@ultra.linux.cz), Patrik Rak 
(prak3264@ss1000.ms.mff.cuni.cz)
description:    Solaris binary emulation module
license:        GPL
vermagic:       2.6.18-5-sparc64-smp SMP mod_unload gcc-4.1
depends:

Now what?

Any attempt to run a Solaris binary results in the following:

manhack:/usr/gnemul/solaris/bin# file ./uname
./uname: ELF 32-bit MSB executable, SPARC, version 1 (SYSV), dynamically 
linked (uses shared libs), stripped
manhack:/usr/gnemul/solaris/bin# ./uname
-bash: ./uname: No such file or directory

I don't know if the Linux ldd is supposed to work on these binaries, but it 
doesn't:

manhack:/usr/gnemul/solaris/bin# ldd ./uname
/usr/bin/ldd: line 117: ./uname: No such file or directory

Running "/lib/ld-linux.so.2 --list" against the Solaris binary segfaults.  I 
would assume that is bad.

manhack:~# /lib/ld-linux.so.2 --list /usr/gnemul/solaris/bin/uname
Segmentation fault

 From the Solaris machine (cds3), I ldd the binary I copied and verify all the 
libraries are on the Linux host:

whardin@cds3 / $ cksum /bin/uname
2504107844 6772 /bin/uname
whardin@cds3 / $ ldd /bin/uname
         libc.so.1 =>     /lib/libc.so.1
         libdl.so.1 =>    /lib/libdl.so.1
         /usr/platform/SUNW,Ultra-60/lib/libc_psr.so.1

manhack:~# cksum /usr/gnemul/solaris/bin/uname
2504107844 6772 /usr/gnemul/solaris/bin/uname
manhack:~# ls /usr/gnemul/solaris/lib 
/usr/gnemul/solaris/usr/platform/SUNW,Ultra-60/lib/
/usr/gnemul/solaris/lib:
ld.so        libc.so.1       libdl.so.1   libmp.so.2   libsecdb.so.1
libcmd.so.1  libcurses.so.1  libgen.so.1  libnsl.so.1

/usr/gnemul/solaris/usr/platform/SUNW,Ultra-60/lib/:
libc_psr.so.1

I'm stumped.  I feel like I just missed a simple step somewhere, but haven't a 
clue what.  Anyone have any pointers or troubleshooting advice?  I've 
installed the libc6-dbg package but have no idea how to make use of it.

-- 
/* wes hardin */
