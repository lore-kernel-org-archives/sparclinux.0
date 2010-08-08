From: David Miller <davem@davemloft.net>
Date: Sun, 08 Aug 2010 08:31:41 +0000
Subject: Re: [PATCH] of/sparc: fix build regression from of_device changes
Message-Id: <20100808.013141.267939698.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100808071628.11437.93510.stgit@angua>
In-Reply-To: <20100808071628.11437.93510.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 08 Aug 2010 01:19:38 -0600

> Commit id 1636f8ac2b08410df4766449f7c86b912443cd99 (sparc/of: Move
> of_device fields into struct pdev_archdata) missed fixing up the
> n2_core.c and greth.c drivers.  This patch makes the required changes.
> 
> Reported-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> David, I've currently got this one in my next-devicetree branch.  You
> can either pick it up, or it can go out when I ask Linus to pull on
> Monday or Tuesday.

Please ask Linus to pull your copy, thanks Grant.
