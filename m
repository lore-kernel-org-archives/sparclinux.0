From: David Miller <davem@davemloft.net>
Date: Thu, 22 Jul 2010 05:28:35 +0000
Subject: Re: [PATCH 3/5] of/platform: remove all of_bus_type and
Message-Id: <20100721.222835.258899665.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100721232817.7782.23410.stgit@angua>
	<20100721234005.7782.52867.stgit@angua>
In-Reply-To: <20100721234005.7782.52867.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, gregkh@suse.de, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 21 Jul 2010 17:40:05 -0600

> Both of_bus_type and of_platform_bus_type are just #define aliases
> for the platform bus.  This patch removes all references to them and
> switches to the of_register_platform_driver()/of_unregister_platform_driver()
> API for registering.
> 
> Subsequent patches will convert each user of of_register_platform_driver()
> into plain platform_drivers without the of_platform_driver shim.  At which
> point the of_register_platform_driver()/of_unregister_platform_driver()
> functions can be removed.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
