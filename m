From: David Miller <davem@davemloft.net>
Date: Wed, 18 Jul 2007 07:36:14 +0000
Subject: Re: Start the consolidation of the OpenFrimware support routines
Message-Id: <20070718.003614.31642446.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
In-Reply-To: <20070718173024.50204a1a.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, wli@holomorphy.com

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 18 Jul 2007 17:30:24 +1000

> Hi Dave, Paul,
> 
> The latest version of the changes is available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sfr/ofcons.git master
> 
> I will send patches to the lists if people want them.  The only changes
> from the previous version is to merge with Linus' current tree (there
> were various conflicts with PowerPC changes).  This has been built for
> Sparc and Sparc64 defconfigs but I have no Sparc hardware to boot on.  It
> has also been built for PowerPC allmodconfig and ppc64_defconfig - the
> latter has been booted on an iSeries box.
> 
> The intention here is that there should be no behavioural changes and
> minimal code changes (apart from movement of the code to common places).
> There are, however a couple of unavoidable changes:
> 	- some of the accessor functions now take a read lock on Sparc[64]
> where they didn't before.
> 	- the bus structures are initialised at runtime.
> 
> If people are happy with this, I will submit it directly to Linus.

No objections here.  If the read lock or bus initialization issue
causes problems, I'll fix it up after this gets merged in, don't worry
about it.
