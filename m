From: David Miller <davem@davemloft.net>
Date: Wed, 07 May 2008 23:12:41 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <20080507.161241.168604785.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 7 May 2008 18:54:06 -0400 (EDT)

> I'm going to need a little help with this, since I'm not acquainted 
> with SPARC assembler.
> 
> The task dump showed that the address on the stack was
> usb_hcd_poll_rh_status+0x40/0x180, which would be ec0 above.  That
> looks like it is the second instruction past the call to
> hcd->driver->hub_status_data().  Is that right?  And does one expect 
> the return address to be two past the call (call slot or some such 
> thing)?

"call" instructions save their PC's into %o7.  The callee jumps
to "%o7 + 8" and that's what's reported in a standard sparc
backtrace.

I looked through the changesets since v2.6.25 in drivers/usb/host/
and there are a couple refactorings of how OHCI and EHCI are
programmed in various situations which would be useful to audit.

In fact a quick way to bisect this bug might be:

	git bisect drivers/usb/host
	git bisect bad
	git bisect good v2.6.25

or something like that.
