From: David Miller <davem@davemloft.net>
Date: Thu, 22 Jul 2010 05:28:28 +0000
Subject: Re: [PATCH 2/5] of: Merge of_platform_bus_type with
Message-Id: <20100721.222828.116132078.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100721232817.7782.23410.stgit@angua>
	<20100721233959.7782.17711.stgit@angua>
In-Reply-To: <20100721233959.7782.17711.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, gregkh@suse.de, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 21 Jul 2010 17:40:00 -0600

> of_platform_bus was being used in the same manner as the platform_bus.
> The only difference being that of_platform_bus devices are generated
> from data in the device tree, and platform_bus devices are usually
> statically allocated in platform code.  Having them separate causes
> the problem of device drivers having to be registered twice if it
> was possible for the same device to appear on either bus.
> 
> This patch removes of_platform_bus_type and registers all of_platform
> bus devices and drivers on the platform bus instead.  A previous patch
> made the of_device structure an alias for the platform_device structure,
> and a shim is used to adapt of_platform_drivers to the platform bus.
> 
> After all of of_platform_bus drivers are converted to be normal platform
> drivers, the shim code can be removed.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
