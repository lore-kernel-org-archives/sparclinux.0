From: David Miller <davem@davemloft.net>
Date: Thu, 29 Jan 2009 23:54:12 +0000
Subject: NMI watchdog...
Message-Id: <20090129.155412.79066523.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I just wanted to let folks know what I've been working on, sparc wise.

I have this reocurring issue where one of my workstations hangs
completely, no keyboard input, no console messages, nothing.

Since we have pseudo-NMI support in oprofile via performance counters
in the current tree I worked on rearchitecting this so that a nice NMI
watchdog layer could be added.

It is modelled after the x86 NMI watchdog, with the major difference
being that it is enabled by default.  The cost is one interrupt per
second, and the payback is enormous wrt. the ability to debug complete
system hangs.

Basically how it works is if we see no timer interrupts processed for
5 seconds we print a message, dump registers, and optionally panic the
system.

This will be supported on any system that has profiling counter
overflow interrupt support.  That essentially means any cpu from
UltraSPARC-III onward (including Niagara chips).

Another nice side effect of this work is that it gives us some of the
framework necessary for whatever generic performance counter layer
gets merged into the tree in the future (Ingo Molnar's work, perfmon3,
whatever).

I noticed while doing these changes that we need some work in the
handling of OOPSes and other errors.  In particular we need to start
using the existing generic infrastructure the kernel provides, such as
oops_enter(), oops_exit(), bust_spinlocks(), etc.  I do intend to work
on this.

I'm currently busy doing testing to make sure that the NMI watchdog
and oprofile work as expected.

I'll post the patches when I check them in.  I intend to push this
into the current stable tree because there are entire classes of bugs
people run into which can't be analyzed at all without this kind of
facility.
