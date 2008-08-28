From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 28 Aug 2008 14:40:09 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.LNX.4.44L0.0808281038000.2464-100000@iolanthe.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 28 Aug 2008, David Miller wrote:

> From: Alan Stern <stern@rowland.harvard.edu>
> Date: Sun, 24 Aug 2008 10:45:47 -0400 (EDT)
> 
> > Okay, that explains it.  So it seems that now everything is working!
> > 
> > My patch (but not the "always post the PCI writes" change) will appear
> > in -rc5 -- it is already in Linus's tree.  After -rc5 is released
> > I'll have an additional patch for you to test, just to make sure it
> > doesn't reintroduce any problems.
> 
> Good to hear it is working, but is there anything we can do
> about those spurious polls?
> 
> Just curious.

Unneeded polls are what I want to address in the additional patch.

However the polls shown in the log aren't necessarily spurious.  The
fact that RHSC interrupt status is broken means that the driver will
have to rely on polling.

Alan Stern

