From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 02 Oct 2004 23:41:54 +0000
Subject: Re: sym2 on sparc
Message-Id: <20041002164154.6918a43c.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041001182056.GI16153@parcelfarce.linux.theplanet.co.uk>
	<1096724000.2157.1.camel@mulgrave>
	<20041002144408.GS16153@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041002144408.GS16153@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: James.Bottomley@SteelEye.com, matthew@wil.cx, sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

On Sat, 2 Oct 2004 15:44:08 +0100
Matthew Wilcox <matthew@wil.cx> wrote:

> > Putting architecture specific knowledge into a device driver is almost
> > never a good thing to do.  If all you want to do is print out the IRQ
> > designation, I suspect this is a generic problem, not a sym2 specific
> > problem, so what we need is something like an irq_to_string()
> > abstraction.
> 
> I agree.  We could probably use something similar on PA-RISC.  There's
> about 25 drivers in-tree that're currently using __irq_itoa().  Most
> of them would be better-written if everybody were using a string.

The strings used to be useful in debugging IRQ routing issues
on sparc64, but that's no longer the case now that I print
out all of the PCI irq routing info at boot time on sparc64 like
so:

PCI-IRQ: Routing bus[ 0] slot[ 2] map[0] to INO[10]
PCI-IRQ: Routing bus[ 0] slot[ 3] map[0] to INO[14]
PCI-IRQ: Routing bus[ 0] slot[ 5] map[0] to INO[1d]
PCI-IRQ: Routing bus[ 0] slot[ 5] map[0] to INO[1e]
PCI-IRQ: Routing bus[ 0] slot[ 5] map[0] to INO[1f]
PCI-IRQ: Routing bus[ 0] slot[ 6] map[0] to INO[18]
PCI-IRQ: Routing bus[ 0] slot[ 6] map[0] to INO[19]
PCI-IRQ: Routing bus[ 1] slot[ 0] map[1] to INO[0d]
PCI-IRQ: Routing bus[ 1] slot[ 1] map[1] to INO[0e]
PCI-IRQ: Routing bus[ 1] slot[ 2] map[1] to INO[0f]
PCI-IRQ: Routing bus[ 1] slot[ 3] map[1] to INO[0c]
PCI0(PBMB): Bus running at 33MHz
PCI-IRQ: Routing bus[ 0] slot[ 1] map[0] to INO[00]
PCI-IRQ: Routing bus[ 0] slot[ 4] map[0] to INO[04]
PCI0(PBMA): Bus running at 66MHz
