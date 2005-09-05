From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 05 Sep 2005 04:14:17 +0000
Subject: Re: PCI device issues between Blade 100 and Blade 100
Message-Id: <20050904.211417.46739147.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050904153024.630204cb@enterprise.weeve.org>
In-Reply-To: <20050904153024.630204cb@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Sun, 4 Sep 2005 15:30:24 -0600

> The IRQ it shows its using when the driver loads seems a bit high,
> but doesn't seem to affect performance.

The IRQ "numbers" the sparc64 port uses internally are actually
pointers to entries in the ivector_table[] in arch/sparc64/kernel/irq.c

The kernel prints out an enormous amount of debugging information
at bootup time, stating the routing of each and every single PCI
interrupt in the system.  On my box it looks like:

PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[1c]
PCI-IRQ: Routing bus[ 0] slot[ 3] map[0] to INO[14]
...

and on and on.  This info might help you diagnose the problem.

Error -16 from request_irq() means EBUSY, ie. another device
has registered a handler for that interrupt number already.
This usually means some driver has failed to specify SA_SHIRQ
in it's request_irq() call.  It's either the EHCI driver (not
very likely) or whatever other device has already registered
with that IRQ, you can figure that out using /proc/interrupts
output.
