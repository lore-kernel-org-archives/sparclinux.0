From: David Miller <davem@davemloft.net>
Date: Sun, 14 Feb 2010 19:50:07 +0000
Subject: Re: [PATCH 8/9] of/sparc: Remove sparc-local declaration of
Message-Id: <20100214.115007.94112348.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100213154838.4767.83881.stgit@angua>
	<20100213160309.4767.94443.stgit@angua>
In-Reply-To: <20100213160309.4767.94443.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: monstr@monstr.eu, sfr@canb.auug.org.au, benh@kernel.crashing.org, jeremy.kerr@canonical.com, microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 13 Feb 2010 09:03:09 -0700

> Both allnodes and devtree_lock are defined in common code.  The
> extern declaration should be in the common header too so that the
> compiler can type check.  allnodes is already in of.h, but
> devtree_lock should be declared there too.
> 
> This patch removes the SPARC declarations and uses decls in of.h instead.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
