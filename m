From: David Miller <davem@davemloft.net>
Date: Fri, 23 Jul 2010 05:50:58 +0000
Subject: Re: [PATCH 1/4] of/device: Replace of_device with platform_device
Message-Id: <20100722.225058.178805105.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100722222600.21557.34167.stgit@angua>
	<20100722223006.21557.84275.stgit@angua>
In-Reply-To: <20100722223006.21557.84275.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, sparclinux@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 22 Jul 2010 16:30:06 -0600

> of_device is currently just an #define alias to platform_device until it
> gets removed entirely.  This patch removes references to it from the
> include directories and the core drivers/of code.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
