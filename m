From: David Miller <davem@davemloft.net>
Date: Fri, 03 Apr 2015 00:42:01 +0000
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <20150402.204201.1019535262608342723.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150402215453.GB15680@oracle.com>
In-Reply-To: <20150402215453.GB15680@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 2 Apr 2015 17:54:53 -0400

> the other question that comes to my mind is: the whole lazy_flush
> optimization probably works best when there is exactly one pool,
> and no large pools. In most other cases, we'd end up doing a lazy_flush
> when we wrap within our pool itself, losing the benefit of that 
> optimization. 
> 
> Given that the lazy_flush is mostly there to avoid regressions for 
> the older sun4u architectures (which have other hardware bottlenecks 
> anyway), and this code is rapidly getting messy, does it make sense
> to constrain the lazy_flush check to only apply for the 1-pool, 
> no-large-pool case?

I think it's better to have the multiple pools with more often global
flushing.
