From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 15 Jan 2009 21:30:37 +0000
Subject: ilog2() problems with gcc-3.4.5
Message-Id: <20090115133037.42ee52aa.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


My sparc64 gcc-3.4.5 cross-compiler has decided to start emitting calls
to ____ilog2_NaN, due to

        eq_context->log_eq_size   = ilog2(eq->nent);

in drivers/net/mlx4/eq.c.  There's another reference coming out of
drivers/net/mlx4/srq.s.

I guess this is a gcc bug - it's gone and decided that
__builtin_constant_p(eq->nent) is true :(

We've had this __builtin_constant_p() bogon occur before now - it
happened with one or two kmalloc() callsites on x86 for some gcc
versions, but we seemed to make it go away by some means.

I guess I can ignore the link errors for now, but it's sad to have to
rub out yet another gcc version.

