From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 15 May 2008 14:33:44 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.LNX.4.44L0.0805151032240.2107-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 15 May 2008, Meelis Roos wrote:

> > I looked through the changesets since v2.6.25 in drivers/usb/host/
> > and there are a couple refactorings of how OHCI and EHCI are
> > programmed in various situations which would be useful to audit.
> > 
> > In fact a quick way to bisect this bug might be:
> > 
> > 	git bisect drivers/usb/host
> > 	git bisect bad
> > 	git bisect good v2.6.25
> > 
> > or something like that.
> 
> Yes, something like that - the first was called git start ... ;)
> 
> Anyway, finally got to bisecting using drivers/usb/host and found the 
> following conmmit through bisecting (for some reason it recompiled most 
> of the kernel each time):
> 
> [705a752162768fed3e2c26fba5bffdd3a3bd04f2] plat-orion: make ehci-orion available for all Orion families
> 
> This is strange - some ARM platform patch that should not matter.
> 
> Should I redo the bisect without restricting to drivers/usb/host?

That would be a good idea.  After all, we have no proof that the lockup 
was caused by a change to the USB code.

Alan Stern

