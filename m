From: David Miller <davem@davemloft.net>
Date: Fri, 03 Dec 2010 18:40:41 +0000
Subject: [PATCH 0/9] Fix PROM call regression.
Message-Id: <20101203.104041.116387856.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The commit to fix huge PROM device node property fetching
25edd6946a1d74e5e77813c2324a0908c68bcf9e ("sparc64: Get rid of
indirect p1275 PROM call buffer.") added a regresion for console
I/O via the PROM.

The issue is that the firmware is not %100 64-bit clean for buffer
addresses, and the code to do firmware console output/input uses an
on-stack buffer which can be above 4GB.

We can't just use a static variable to solve this issue otherwise two
threads can race and corrupt the static variable by trying to use it
at the same time.

So the following set of patches do the following:

1) Eliminate all unused PROM interfaces which pass buffers
   by address to the firmware.

   This way we have less things to "fix" and audit, and it's
   a waste of time to try and adjust the buffer handling of
   routines when we don't have any idea how they'll even be
   used.

2) Unexport and mark as static routines which are only used
   internally by other PROM routines.

3) Consolidate all the console output paths into a final
   routine which takes a multi-character buffer to output,
   and it's length.

4) On sparc64 have an indirect buffer, and a protecting spinlock,
   which is used to make sure that the console output call uses
   a buffer in the low 4GB of the virtual address space.

The costs of #3 are OK because the PROM console output is only
used as our early boot console.


