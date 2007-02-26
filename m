From: David Miller <davem@davemloft.net>
Date: Mon, 26 Feb 2007 23:16:36 +0000
Subject: Re: 2.6.20 unaligned accesses
Message-Id: <20070226.151636.74746822.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200702231155.25915.andrew@walrond.org>
In-Reply-To: <200702231155.25915.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Emanuele Rocca <ema@debian.org>
Date: Tue, 27 Feb 2007 00:14:49 +0100

> Hello,
> 
> * Andrew Walrond <andrew@walrond.org>, [2007-02-23 11:55 +0000]:
> >  On a Sun T1000 running 2.6.20 I'm seeing lots of these:
> >  
> >  Kernel unaligned access at TPC[63d47c] Kernel unaligned access at TPC[63d47c] 
> >  Kernel unaligned access at TPC[63d47c] aoenet_rcv+0xa4/0x190
> [...]
> 
> On a Sun Blade 2000 I got this one every time I load eth1394:
> Kernel unaligned access at TPC[101880c8] ether1394_reset_priv+0x2c/0xb8 [eth1394]
> 
> I got rid of the message with the following patch:

That is a different bug, and the current 2.6.x tree already has
that fix applied so you shouldn't need to apply that patch to
the vanilla tree.
