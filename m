From: Andrew Walrond <andrew@walrond.org>
Date: Mon, 26 Feb 2007 10:12:32 +0000
Subject: Re: 2.6.20 unaligned accesses
Message-Id: <200702261012.32617.andrew@walrond.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200702231155.25915.andrew@walrond.org>
In-Reply-To: <200702231155.25915.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Friday 23 February 2007 11:55, Andrew Walrond wrote:
> On a Sun T1000 running 2.6.20 I'm seeing lots of these:
>
> Kernel unaligned access at TPC[63d47c] Kernel unaligned access at
> TPC[63d47c] Kernel unaligned access at TPC[63d47c] aoenet_rcv+0xa4/0x190
> aoenet_rcv+0xa4/0x190
> aoenet_rcv+0xa4/0x190
> Kernel unaligned access at TPC[63d47c] Kernel unaligned access at
> TPC[63d47c] Kernel unaligned access at TPC[63d47c] aoenet_rcv+0xa4/0x190
> aoenet_rcv+0xa4/0x190
>

I have discovered that these only appear when running a kernel with

	CONFIG_CC_OPTIMIZE_FOR_SIZE=y

Nevertheless, I guess it needs fixing.

Andrew Walrond
