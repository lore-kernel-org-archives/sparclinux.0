From: Chris Newport <crn@netunix.com>
Date: Tue, 18 Dec 2007 02:58:29 +0000
Subject: Re: No dma_sync_* during pci_probe? (Sparc, post 2.6.22 regression)
Message-Id: <Pine.LNX.4.60.0712180255450.10484@mailgate.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <bug-9160-4803@http.bugzilla.kernel.org/> <47112797.7060003@s5r6.in-berlin.de>
 <47670BDF.80409@s5r6.in-berlin.de>
In-Reply-To: <47670BDF.80409@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>, linux1394-devel@lists.sourceforge.net

On Tue, 18 Dec 2007, Stefan Richter wrote:

> It's a 100% reproducible oops on Sparc (with FireWire controller) for
> 2.6.23 and 2.6.24 kernels, but not 2.6.22.  The reporter confirmed that
> the bug also happens

How do you achieve a sparc system with firewire ?
AFAIK there is no SBUS firewire card.

Only sparc64 and some rare javastations have PCI slots.

