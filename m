From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 05 Apr 2015 12:26:01 +0000
Subject: Re: [PATCHv9 RFC 1/3] Break up monolithic iommu table/lock into finer graularity pools and lock
Message-Id: <1428236761.20500.315.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1428181553.git.sowmini.varadhan@oracle.com>
 <a259c5bbc3d98dbaedc73a88250a5e7c937ec5f9.1428181553.git.sowmini.varadhan@oracle.com>
In-Reply-To: <a259c5bbc3d98dbaedc73a88250a5e7c937ec5f9.1428181553.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Sun, 2015-04-05 at 07:49 -0400, Sowmini Varadhan wrote:
> +               if (likely(pass = 0)) {
> +                       /* First failure, rescan from the beginning.
> */
> +                       pool->hint = pool->start;
> +                       set_flush(iommu);
> +                       pass++;
> +                       goto again;
> +               } else if (!largealloc && pass <= iommu->nr_pools) {
> +                       spin_unlock(&(pool->lock));
> +                       pool_nr = (pool_nr + 1) & (iommu->nr_pools -
> 1);
> +                       pool = &(iommu->pools[pool_nr]);
> +                       spin_lock(&(pool->lock));
> +                       pool->hint = pool->start;
> +                       set_flush(iommu);
> +                       pass++;
> +                       goto again;

So you decided to keep the logic here that updates the hint instead of
just getting rid of need_flush alltogether ?

Out of curiosity, what's the rationale ? Did you find a reason why
resetting the hint in those two cases (rather than just setting "start"
appropriately) is actually useful ?

Cheers,
Ben.


