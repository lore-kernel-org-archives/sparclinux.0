From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 28 Oct 2004 00:33:16 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20041027173316.1c7104f2.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 27 Oct 2004 19:57:39 -0400
mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:

> Also, who is in charge reserving these these 2 TLB entries ? silo?
> How big is sparc64's TLB? This is a bit OT but I read something that 
> said x86 processors have a really small TLB. What do we do on x86 to
> boot the kernl? How about other procs?

The kernel locks these two TLB entires into the MMU.  It only locks
one if the kernel image is 4MB or smaller.

We lock these entries into the TLB because the TLB is reloaded by
software trap handlers.  Therefore we have to at least lock enough
of the kernel image into the TLB such that the trap handler mappings
itself does not incur a TLB miss.

The x86 processor does TLB replacement in hardware, not software.
So something like this is not needed there.

The number of TLB entries varies by UltraSPARC, 64 in older chips
(pre ultrasparc-III) and 16 (of the kind that can be locked) in
ultrasparc-III and later.

Just make you silly kernel images smaller.  My arch/sparc64/boot/image
is typically 3.8MB or smaller.  Even if you want all that debugging
information in the kernel image (ie. building with "-g" in cflags or
whatever) you don't need all of that extra stuff in the kernel image
that is actually booted.  Copy over the vmlinux file with all the
stuff in it to some place where you can run gdb on it or whatever
it is you need the debugging info for, then use a seperate copy for
booting under /boot and strip the crap out of that file so that it
is as small as possible.
