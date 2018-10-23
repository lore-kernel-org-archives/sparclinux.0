From: David Miller <davem@davemloft.net>
Date: Tue, 23 Oct 2018 02:19:20 +0000
Subject: [PATCH 0/8] sparc: VDSO improvements
Message-Id: <20181022.191920.1018836687109106651.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

    
I started out on these changes with the goal of improving perf
annotations when the VDSO is in use.  Due to lack of inlining the
helper functions are typically hit when profiling instead of
__vdso_gettimeoday() or __vdso_vclock_gettime().

The only symbols available by default are the dyanmic symbols,
which therefore doesn't cover the helper functions.

So the perf output looks terrible, because the symbols cannot be
resolved and all show up as "Unknown".

The sparc VDSO code forces no inlining because of the way the
simplistic %tick register read code patching works.  So fixing that
was the first order of business.  Tricks were taken from how x86
implements alternates.  The crucial factor is that if you want to
refer to locations (for the original and patch instruction(s)) you
have to do so in a way that is resolvable at link time even for a
shared object.  So you have to do this by storing PC-relative
values, and not in executable sections.

Next, we sanitize the Makefile so that the cflags et al. make more
sense.  And LDFLAGS are applied actually to invocations of LD instead
of CC.

We also add some sanity checking, specifically in a post-link check
that makes sure we don't have any unexpected unresolved symbols in the
VDSO.  This is essential because the dynamic linker cannot resolve
symbols in the VDSO because it cannot write to it.

Finally some very minor optimizations are preformed to the
vclock_gettime.c code.  One thing which is tricky with this code on
sparc is that struct timeval and struct timespec are layed out
differently on 64-bit.  This is because, unlike other architectures,
sparc defined suseconds_t as 'int' even on 64-bit.  This is why we
have all of the "union" tstv_t" business and the weird assignments
in __vdso_gettimeofday().

Performance wise we do gain some cycle shere, specifically here
are cycle counts for a user application calling gettimeofday():

        no-VDSO         VDSO-orig       VDSO-new
========================
64-bit  853 cycles      112 cycles      125 cycles
32-bit  849 cycles      134 cycles      141 cycles

These results are with current glibc sources.

To get better we'd need to implement this in assembler, and I might
just do that at some point.

Signed-off-by: David S. Miller <davem@davemloft.net>
