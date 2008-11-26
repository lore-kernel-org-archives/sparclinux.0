From: David Miller <davem@davemloft.net>
Date: Wed, 26 Nov 2008 08:40:35 +0000
Subject: [PATCH 0/6]: Improved 'NMI' oprofile profiling support.
Message-Id: <20081126.004035.59317715.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Basically what happens right now on sparc64 with oprofile
is that as soon as a code path turns off cpu interrupts
(by writing 15 into the %pil register) nothing in that code
block can take profiling hits since we use the simple timer
interrupt for oprofile support.

These next 6 patches do a few things to improve that situation:

1) We run the kernel at %pil 0 and 14 normally.  This turns
   %pil level 15 into a pseudo-NMI for profiling.

2) An interface is created to register handlers for the
   level 15 interrupt, for profiling counter overflows on
   cpus that have it.  (Basically, UltraSPARC-III and later)

3) Finally, for now on only UltraSPARC-III and derivative chips,
   we use the profiling counters as a 'nmi' timer for oprofile.

As a result, when this stuff is enabled, code sequences run
with interrupts disabled are profiled fully.  This gets us
on-par with x86 which has had a real hardware NMI profiling
handler forever.

I'll add sun4v cpu support for this in a bit.  The code is
simple, I just want to test it properly.

All of this code is commited to sparc-next-2.6
