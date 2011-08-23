From: David Miller <davem@davemloft.net>
Date: Tue, 23 Aug 2011 00:36:02 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110822.173602.1805061969787592036.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Mon, 22 Aug 2011 19:38:39 -0400

> Hi,
> 
> My Sun Blade 100 hangs when I boot any recent kernel.  I've tried many
> Debian and Gentoo installation CDs, but every CD made since 2008 or so
> prints "console [tty0] enabled, bootconsole disabled" and hangs.  I have
> to use Gentoo's 2007.0 install CD to in order to complete booting and
> not disable the bootconsole.
> 
> I've built Linux 3.0.3 and tried it with the same results.  When I boot
> with the "keep_bootcon" kernel parameter I see that Linux is kernel
> panicking in pci_scan_one_pbm.
> 
> I've attached photos of the full kernel panic along with my .config to
> this bugzilla report:
> 
> https://bugzilla.kernel.org/show_bug.cgi?idA522
> 
> Please let me know if you'd like any further information from me.

Unfortunately we need the very first crash message that happens, but
even your first snapshot is after other crashes have occurred.

You'll need to build a kernel with CONFIG_BOOT_PRINTK_DELAYED enabled
and then you can boot with boot_delay=xxx (where "xxx" is something
like 100, it's in milliseconds) to slow down the message printing so
that you can capture the first message cleanly.
