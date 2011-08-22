From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Mon, 22 Aug 2011 23:38:39 +0000
Subject: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

My Sun Blade 100 hangs when I boot any recent kernel.  I've tried many
Debian and Gentoo installation CDs, but every CD made since 2008 or so
prints "console [tty0] enabled, bootconsole disabled" and hangs.  I have
to use Gentoo's 2007.0 install CD to in order to complete booting and
not disable the bootconsole.

I've built Linux 3.0.3 and tried it with the same results.  When I boot
with the "keep_bootcon" kernel parameter I see that Linux is kernel
panicking in pci_scan_one_pbm.

I've attached photos of the full kernel panic along with my .config to
this bugzilla report:

https://bugzilla.kernel.org/show_bug.cgi?idA522

Please let me know if you'd like any further information from me.

thanks,
Jim Faulkner

