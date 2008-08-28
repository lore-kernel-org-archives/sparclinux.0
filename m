From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 10:03:56 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <20080828.030356.136257466.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>
Date: Sun, 24 Aug 2008 10:45:47 -0400 (EDT)

> Okay, that explains it.  So it seems that now everything is working!
> 
> My patch (but not the "always post the PCI writes" change) will appear
> in -rc5 -- it is already in Linus's tree.  After -rc5 is released
> I'll have an additional patch for you to test, just to make sure it
> doesn't reintroduce any problems.

Good to hear it is working, but is there anything we can do
about those spurious polls?

Just curious.
