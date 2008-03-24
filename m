From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Mon, 24 Mar 2008 19:53:22 +0000
Subject: build breakage on sparc64 due to commit 54cd6dde
Message-Id: <200803242053.22709.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

	I get this error when building latest Linus git (and 2.6.25-rc5-mm1) tree:

arch/sparc64/kernel/asm-offsets.c:1: error: -m64 is not supported by this configuration
arch/sparc64/kernel/asm-offsets.c:1: error: -mlong-double-64 not allowed with -m64
arch/sparc64/kernel/asm-offsets.c:1: error: -mcmodel= is not supported on 32 bit systems
make[1]: *** [arch/sparc64/kernel/asm-offsets.s] Error 1

and I bisected it to:

54cd6ddec77b75e6926d73d263aec72255b24030 is first bad commit
commit 54cd6ddec77b75e6926d73d263aec72255b24030
Author: David S. Miller <davem@davemloft.net>
Date:   Thu Feb 14 00:37:21 2008 -0800

    [SPARC64]: Remove Makefile code for ancient gcc and binutils.
    
    The kernel hasn't supported the compilers which need these tests
    for years.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

Here are some details you may need:

Linux sparc64 2.6.24 #9 SMP PREEMPT Mon Jan 28 22:37:42 CET 2008 sparc64 sun4u TI UltraSparc II (BlackBird) GNU/Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.18
util-linux             2.13
mount                  2.13
module-init-tools      3.4
e2fsprogs              1.40.6
Linux C Library        2.6.1
Dynamic linker (ldd)   2.6.1
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.13
Sh-utils               6.9
udev                   115
Modules Loaded         sg sr_mod cdrom

If you want any additional info about gcc, binutils, etc let me know. This build error
comes from allnoconfig configuration but I also see it on my regular sparc64 config.

	Mariusz

