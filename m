From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 07 May 2008 23:31:50 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <Pine.LNX.4.44L0.0805071930350.15419-100000@netrider.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 7 May 2008, David Miller wrote:

> I looked through the changesets since v2.6.25 in drivers/usb/host/
> and there are a couple refactorings of how OHCI and EHCI are
> programmed in various situations which would be useful to audit.

But the problem occurred when a UHCI controller was registered.  What 
makes you think OHCI or EHCI has anything to do with it?

> In fact a quick way to bisect this bug might be:
> 
> 	git bisect drivers/usb/host
> 	git bisect bad
> 	git bisect good v2.6.25
> 
> or something like that.

Yes indeed.

Alan Stern

