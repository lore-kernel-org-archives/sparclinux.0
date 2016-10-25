From: David Miller <davem@davemloft.net>
Date: Tue, 25 Oct 2016 15:01:17 +0000
Subject: [PATCH 0/11] Fix sparc exception reporting.
Message-Id: <20161025.110117.2258578389517613554.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The sparc64 user copy routines do not always accurately report the
residual length when a page fault occurs.  This is because it tries
to use the reported fault address to make this calculation but that
cannot work for several reasons.

First of all, some chips only report a page aligned fault address.
So we need to reconstruct which direction (source or destination)
faulted and where inside that buffer the fault occurred.

It gets even more hairy (read as: impossible) to figure this out
for copy_in_user() where either direction could have faulted.

Fix this by doing it right, by calculating the residual using the
running length which has to be maintained by the assembler code
anyways.

This results in a lot of stubs unfortunately for two reasons:

1) Sparc64's copy routines sometimes require various kinds of
   cleanups.  For example the %asi register might need to be
   restored, or we need to finish using the FPU properly.

2) Various code stretches put the remaining length in various
   places.  For example, before the innermost loop, we might
   have a length used to determine how many bytes to copy to
   make the buffer aligned for the inner loop.  So the residual
   is the sum of two registers plus-or-minus some constant
   offset.

Certainly, if these routines were being written now, the length
register maintainence might have been coded differently in order
to make the stubs simpler.  But rewriting how all of that works
is certainly not practical now.

After the conversion all of the user fixup code can just get
removed and trouble us no longer.

Signed-off-by: David S. Miller <davem@davemloft.net>

