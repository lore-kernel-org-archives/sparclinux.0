From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 09 Jun 2012 17:08:55 +0000
Subject: linux-3.5-rc1 on hypersparc
Message-Id: <CA+=Fv5T__1Gt6P=pxEnn6LFu1j=vpod7cSMvnYMnktSJSdqD+A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi All,

I've done some testing with Marcels "revert.patch" that reverts some
of the changes to kernel 2.6.32 that broke hypersparc support.
I can now boot my ss20 with dual hypersparc with an SMP kernel
3.5-rc1. System boots and it seems to run fine. I'm running a
home-brew gentoo-sparc32 However, when running "emerge syslog-ng"
on a fresh gentoo install I get an error
running automake: "panic: memory wrap at: xxxxx". This error does not
appear with kernel 2.6.31.9 suggesting that there is indeed some weird
cache alias effect like Dave mentioned. This error does not occur on
supersparc-II when running the revert.patched kernel 3.5-rc1,
suggesting that its hypersparc specific?

I boot my kernels from disk, using a modified silo that allows me to
use kernels up to about 2.8meg. This lets me boot a smp kernel with
some debuggin info.Still, there is an upper limit so a relocatable
sparc32 kernel would
be really nice indeed!


After applying "revert.patch" I've also replaced arch/sparc/lib/memcpy.S in the
3.5-rc1 kernel with the same file from the 2.6.32.59 kernel. After
building the new kernel with the replaced memcpy.S the previous errors
due to memory aliasing disappeared. I can't say that there are no
hidden aliasing bugs left, but the failures I experienced earlier are
now gone and I've been able to do an "emerge -Du world" with a 3.5-rc1 kernel.
It took the dual hypersparc something between 2-3 days to update the
gentoo system
but it did not freeze or give any errors.

building a kernel with "make -j4" on the hypersparc will eventually
cause the system to freeze
on a smp kernel.


Magnus LIndholm
