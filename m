From: David Miller <davem@davemloft.net>
Date: Wed, 16 Jun 2010 21:06:38 +0000
Subject: Re: [PATCH 1/2] sparc/of: Move of_device fields into struct
Message-Id: <20100616.140638.115932212.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100604205930.2762.17131.stgit@angua>
	<20100604211132.2762.54164.stgit@angua>
In-Reply-To: <20100604211132.2762.54164.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: sparclinux@vger.kernel.org, sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 04 Jun 2010 15:11:33 -0600

> This patch moves SPARC architecture specific data members out of
> struct of_device and into the pdev_archdata structure.  The reason
> for this change is to unify the struct of_device definition amongst
> all the architectures.  It also remvoes the .sysdata, .slot, .portid
> and .clock_freq properties because they aren't actually used by
> anything.
> 
> A subsequent patch will replace struct of_device entirely with struct
> platform_device and the of_platform support code will share common
> routines with the platform bus (but the bus instances themselves can
> remain separate).
> 
> This patch also adds 'struct resources *resource' and num_resources
> to match the fields defined in struct platform_device.  After this
> change, 'struct platform_device' can be used as a drop-in replacement
> for 'struct of_platform'.
> 
> This change is in preparation for merging the of_platform_bus_type
> with the platform_bus_type.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
