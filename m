From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 03:24:12 +0000
Subject: Re: Fix for sparc64 irq.c compile error
Message-Id: <20051009.202412.110750797.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sven Hartge <hartge@ds9.argh.org>
Date: Sun, 9 Oct 2005 16:54:01 +0200 (CEST)

[ Please use sparclinux, you'll reach more Sparc users there.
  ultralinux ought to be deprecated at some point since there
  is zero traffic level justification for two lists these days ]

> init(495): Oops [#1]
> TSTATE: 0000000011009600 TPC: 0000000000534ce4 TNPC: 0000000000534ce8 Y: 00000000    Not tainted
> TPC: <tty_wakeup+0x4/0x80>

Known problem with serial console, I mean to get to fixing it
at some point.
