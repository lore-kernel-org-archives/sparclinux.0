From: Bob Picco <bpicco@meloft.net>
Date: Thu, 25 Sep 2014 22:37:18 +0000
Subject: Re: [PATCH 0/6] sparc64: MM/IRQ patch queue.
Message-Id: <20140925223718.GH4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140925.154047.2222645314356554322.davem@davemloft.net>
In-Reply-To: <20140925.154047.2222645314356554322.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Thu Sep 25 2014, 03:40:47PM EDT]
> 
> Bob, here is the queue of changes that are in my local tree and I
> think are just about ready to push out.
> 
> They include all of the MM work we did to increase the max phys
> bits and fix DEBUG_PAGEALLOC, as well as the sparseirq stuff.
> 
> The kernel is so much smaller now, about 7.4MB compared to what used
> to be nearly 14MB.  We almost halved the size, and I bet there is some
> more low hanging fruit out there.  So we are significantly within the
> range of only needing 2 locked TLB entries to hold the kernel (we used
> to need 4).
You might want to tone these down:
[10014000000-100147fffff] PMD -> [ffff801fda800000-ffff801fdaffffff] on node
or terminate them altogether. Only a suggestion and will inspect further.
> 
> I'm eager to push this, but I also want it to get tested so I'll hold
> off for about a day or so in order to give some time for that.
DEBUG_PAGEALLOC wasn't healthy on T5-2. I'll scrutinize further in the
morning. It could be a legitimate issue. Ah I've seen this in kexec for
restart on oops case:
[37729.365306] ixgbe 0001:03:00.1 eth1: NIC Link is Up 1 Gbps, Flow Control: RX/TX
[37729.380874] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[37733.378191] ixgbe 0001:03:00.1 eth1: Detected Tx Unit Hang
[37733.378191]   Tx Queue             <11>
[37733.378191]   TDH, TDT             <0>, <1>
[37733.378191]   next_to_use          <1>
[37733.378191]   next_to_clean        <0>
[37733.378191] tx_buffer_info[next_to_clean]
[37733.378191]   time_stamp           <ffffae52>
[37733.378191]   jiffies              <ffffaf76>
[37733.445218] ixgbe 0001:03:00.1 eth1: tx hang 1 detected on queue 11, resetting adapter
[37733.460961] ixgbe 0001:03:00.1 eth1: initiating reset due to tx timeout
[37733.474246] ixgbe 0001:03:00.1 eth1: Detected Tx Unit Hang
.
> 
> In particular, I'd be real interested in how the new code handles that
> stress test wherein a guest was created with an insanely fragmented
> memory map, I suspect we still need a bump of MAX_BANKS for that guy.
> If you could figure out what kind of value that test needs and let
> me know, I'd appreciate it.
> 
> Thanks!
you're welcome

Later!
