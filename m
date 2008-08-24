From: Alan Stern <stern@rowland.harvard.edu>
Date: Sun, 24 Aug 2008 14:45:47 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.LNX.4.44L0.0808241041540.7778-100000@netrider.rowland.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 23 Aug 2008, David Miller wrote:

> From: Alan Stern <stern@rowland.harvard.edu>
> Date: Sat, 23 Aug 2008 14:37:42 -0400 (EDT)
> 
> > But what happened to the two ohci_info() calls I had you include?  At 
> > least one of them should show up.  Unless for some reason you have 
> > CONFIG_PM disabled?
> 
> CONFIG_PM is not supported on sparc64

Okay, that explains it.  So it seems that now everything is working!

My patch (but not the "always post the PCI writes" change) will appear
in -rc5 -- it is already in Linus's tree.  After -rc5 is released
I'll have an additional patch for you to test, just to make sure it
doesn't reintroduce any problems.

Alan Stern

