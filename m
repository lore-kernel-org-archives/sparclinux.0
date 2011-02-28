From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 28 Feb 2011 07:35:29 +0000
Subject: Re: [RFC PATCH 01/15] dt/powerpc: move of_bus_type infrastructure
Message-Id: <20110228073529.GA7855@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
 <20110223043340.20795.84024.stgit@localhost6.localdomain6>
 <201102241546.48790.arnd@arndb.de>
In-Reply-To: <201102241546.48790.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree-discuss@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, davem@davemloft.net, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Thu, Feb 24, 2011 at 03:46:48PM +0100, Arnd Bergmann wrote:
> On Wednesday 23 February 2011, Grant Likely wrote:
> > arch/powerpc/kernel/ibmebus.c is the only remaining user of the
> > of_bus_type support code for initializing the bus and registering
> > drivers.  All others have either been switched to the vanilla platform
> > bus or already have their own infrastructure.
> > 
> > This patch moves the functionality that ibmebus is using out of
> > drivers/of/{platform,device}.c and into ibmebus.c where it is actually
> > used.  Also renames the moved symbols from of_platform_* to
> > ibmebus_bus_* to reflect the actual usage.
> > 
> > This patch is part of moving all of the of_platform_bus_type users
> > over to the platform_bus_type.
> > 
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> 
> The ibmebus is essentially the platform bus of the IBM Power Systems (a.k.a.
> pSeries a.k.a. System p), I think it would make a lot of sense to convert
> the two drivers (ehca and ehea) on this bus into platform drivers as well.
> 
> The original reason for this bus was to provide a different IOMMU for them
> than what is used on the PCI devices. This should now be possible in simpler
> ways.

Agreed.  Anybody want to volunteer to craft a patch?

In the mean time, do you have any problem with this patch?  (assuming
nobody is able to take on the task of converting those drivers
immediately).

g.

