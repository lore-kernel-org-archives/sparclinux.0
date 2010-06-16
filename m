From: David Miller <davem@davemloft.net>
Date: Wed, 16 Jun 2010 21:07:06 +0000
Subject: Re: [PATCH 2/2] of: kill struct of_device
Message-Id: <20100616.140706.48510350.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100604205930.2762.17131.stgit@angua>
	<20100604211138.2762.35074.stgit@angua>
In-Reply-To: <20100604211138.2762.35074.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, benh@kernel.crashing.org, devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 04 Jun 2010 15:11:38 -0600

> Now that the device tree node pointer has been moved out of struct
> of_device and into the common struct device, there isn't anything
> unique about of_device anymore.  In fact, there isn't much need
> for a separate of_bus when all busses have access to OF style
> probing.
> 
> arch/powerpc and arch/microblaze are moving away from using the of_bus
> and using the regular platform bus instead for mmio devices.  This
> patch makes of_device the same as platform_device as a stepping stone
> in migrating of_platform_drivers over to the platform bus.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
