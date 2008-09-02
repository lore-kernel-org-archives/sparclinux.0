From: David Miller <davem@davemloft.net>
Date: Tue, 02 Sep 2008 08:09:44 +0000
Subject: generic IRQs for sparc32
Message-Id: <20080902.010944.25269623.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


One thing I've been wanting to do for a long time is convert
the 32-bit sparc code over to the generic IRQ layer.

I had a prototype patch in my back pocket that I've been
trying to resurrect, but there were some difficult issues
to overcome as long as the EBUS and SBUS layers were still
around.

So now that I've gotten rid of those turds, I can make a
stronger push on the generic IRQ patch.

Even if I finish this work quickly I won't push it into
sparc-next-2.6 until I get at least some testing feedback.

Is there anyone booting sparc32 successfully with sparc-next-2.6
any time after the SBUS removal changes went in?  At least one
person appeared to be trying, and ran into that build problem
with CONFIG_PCI (which I fixed).

It would be good to know where things stand so that we can better
compare the state of affairs after the generic IRQs changes get
applied.

Thanks.
