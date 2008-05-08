From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 08 May 2008 14:06:47 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.LNX.4.44L0.0805080958060.2353-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 7 May 2008, David Miller wrote:

> From: Alan Stern <stern@rowland.harvard.edu>
> Date: Wed, 7 May 2008 19:31:50 -0400 (EDT)
> 
> > On Wed, 7 May 2008, David Miller wrote:
> > 
> > > I looked through the changesets since v2.6.25 in drivers/usb/host/
> > > and there are a couple refactorings of how OHCI and EHCI are
> > > programmed in various situations which would be useful to audit.
> > 
> > But the problem occurred when a UHCI controller was registered.  What 
> > makes you think OHCI or EHCI has anything to do with it?
> 
> Read the reporter's boot logs.  Their system (Sun Fire V100) has OHCI
> host controllers.
> 
> And right after registerring OHCI is when it hangs:

Ah yes, I see.  So why did I think this was related to UHCI?  <Goes
back and re-reads old email messages...>  Answer: Because you said so 
in your original posting to linux-usb.

This means that the routine to look at is ohci_hub_status_data() in 
drivers/usb/host/ohci-hub.c, not the corresponding UHCI routine.  But 
everything else is pretty much the same; it would still help to add 
printk statements before and after the spin_lock_irqsave() call.  Maybe 
also a printk just before the final "return" statement.

Alan Stern

