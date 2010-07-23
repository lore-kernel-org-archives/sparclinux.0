From: David Miller <davem@davemloft.net>
Date: Fri, 23 Jul 2010 20:04:02 +0000
Subject: Re: [PATCH] of: make of_find_device_by_node generic
Message-Id: <20100723.130402.232759717.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100723200217.18363.48627.stgit@angua>
In-Reply-To: <20100723200217.18363.48627.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: jonas@southpole.se, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 23 Jul 2010 14:02:17 -0600

> From: Jonas Bonn <jonas@southpole.se>
> 
> There's no need for this function to be architecture specific and all four
> architectures defining it had the same definition.  The function has been
> moved to drivers/of/platform.c.
> 
> Signed-off-by: Jonas Bonn <jonas@southpole.se>
> [grant.likely@secretlab.ca: moved to drivers/of/platform.c, simplified code, and added kerneldoc comment]
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
