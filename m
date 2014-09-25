From: David Miller <davem@davemloft.net>
Date: Thu, 25 Sep 2014 19:40:47 +0000
Subject: [PATCH 0/6] sparc64: MM/IRQ patch queue.
Message-Id: <20140925.154047.2222645314356554322.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Bob, here is the queue of changes that are in my local tree and I
think are just about ready to push out.

They include all of the MM work we did to increase the max phys
bits and fix DEBUG_PAGEALLOC, as well as the sparseirq stuff.

The kernel is so much smaller now, about 7.4MB compared to what used
to be nearly 14MB.  We almost halved the size, and I bet there is some
more low hanging fruit out there.  So we are significantly within the
range of only needing 2 locked TLB entries to hold the kernel (we used
to need 4).

I'm eager to push this, but I also want it to get tested so I'll hold
off for about a day or so in order to give some time for that.

In particular, I'd be real interested in how the new code handles that
stress test wherein a guest was created with an insanely fragmented
memory map, I suspect we still need a bump of MAX_BANKS for that guy.
If you could figure out what kind of value that test needs and let
me know, I'd appreciate it.

Thanks!
