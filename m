From: Andrew Walrond <andrew@walrond.org>
Date: Fri, 23 Feb 2007 11:55:25 +0000
Subject: 2.6.20 unaligned accesses
Message-Id: <200702231155.25915.andrew@walrond.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On a Sun T1000 running 2.6.20 I'm seeing lots of these:

Kernel unaligned access at TPC[63d47c] Kernel unaligned access at TPC[63d47c] 
Kernel unaligned access at TPC[63d47c] aoenet_rcv+0xa4/0x190
aoenet_rcv+0xa4/0x190
aoenet_rcv+0xa4/0x190
Kernel unaligned access at TPC[63d47c] Kernel unaligned access at TPC[63d47c] 
Kernel unaligned access at TPC[63d47c] aoenet_rcv+0xa4/0x190
aoenet_rcv+0xa4/0x190

Google found similar reports and fixes by David Miller (cc'ed), suggesting 
that more agressive structure packing by gcc 4.1.1 was exposing buggy code, 
so perhaps this is a similar case? (I am also using gcc-4.1.1)

Is this just an 'unaligned accesses are slower' issue, or simething more 
serious?

Let me know if I can do anything to further diagnose or test.

Andrew Walrond
