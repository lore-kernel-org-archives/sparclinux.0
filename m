From: David Miller <davem@davemloft.net>
Date: Thu, 15 Oct 2009 00:54:26 +0000
Subject: Re: Linux guest domain with two vnets bound to the same vswitch
Message-Id: <20091014.175426.180344605.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <505766fa0909222137q217be3d0x8fc12ab467833666@mail.gmail.com>
In-Reply-To: <505766fa0909222137q217be3d0x8fc12ab467833666@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


[ Please retain CC: in all replies, thanks. ]

Hey, I want to investigate this further because something about
these traces still perplexes me.

Could you get me some information?

1) Setup the failing case (but with one of the fixes in the kernel
   so you can run commands), and grab the contens of /proc/interrupts
   and post that output here.

2) What firmware and hypervisor are you running on this machine?
   (you can get this via 'showhost' at the "sc>" prompt)

   I'm running Sun System Firmware 7.1.7.h on my machine.

The reason I ask #2 is that there is a hypervisor bug with LDC
connections wherein the interrupt can be sent twice erroneously
and this can cause loops in the per-cpu interrupt INO list.

There is a partial workaround already in the tree:

commit 5a606b72a4309a656cd1a19ad137dc5557c4b8ea
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Jul 9 22:40:36 2007 -0700

    [SPARC64]: Do not ACK an INO if it is disabled or inprogress.
    
    This is also a partial workaround for a bug in the LDOM firmware which
    double-transmits RX inos during high load.  Without this, such an
    event causes the kernel to loop forever in the interrupt call chain
    ACK'ing but never actually running the IRQ handler (and thus clearing
    the interrupt condition in the device).
    
    There is still a bad potential effect when double INOs occur,
    not covered by this changeset.  Namely, if the INO is already on
    the per-cpu INO vector list, we still blindly re-insert it and
    thus we can end up losing interrupts already linked in after
    it.
    
    We could deal with that by traversing the list before insertion,
    but that's too expensive for this edge case.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

But, as stated, it cannot deal with all possibilities that result
from this firmware bug.  Best is to have the most uptodate firmware
with the fix.
