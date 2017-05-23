From: Palmer Dabbelt <palmer@dabbelt.com>
Date: Tue, 23 May 2017 22:05:39 +0000
Subject: Unify the various copies of libgcc into lib
Message-Id: <20170523220546.16758-1-palmer@dabbelt.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

I'm in the process of submitting the RISC-V Linux port, and someone noticed
that we were adding copies of some libgcc emulation routines that were the same
as some of the other ports.  This prompted me to go through and check all the
ports for libgcc.h and to merge the versions that were functionally identical.

The only difference in libgcc.h was that there was a #define for little vs big
endian.  The differences in the emulation routines were all just whitespace.

This patch set comes in two parts:

 * Patch 1 adds new copies of all the C files copied from libgcc, as well as
   moving libgcc.h to include/lib (that's a new folder, which probably means
   it's the wrong place to put it, but I couldn't find anything better).  There
   are Kconfig entries for each of these library functions so architectures can
   select them one at a time.

 * The rest of the patches convert each architecture over to the new system.

Unless I screwed something up, this patch set shouldn't actually change any
functionality.  Unfortunately I don't actually have all these cross compilers
setup so I can't actually test any of this, but I did convert the RISC-V port
over to using this system and it appears to be OK there so at least this isn't
completely broken.

