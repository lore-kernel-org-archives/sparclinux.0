From: David Miller <davem@davemloft.net>
Date: Tue, 24 Mar 2015 02:15:08 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150323.221508.1178754097347144400.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1427149265.4770.238.camel@kernel.crashing.org>
 <20150323.214453.255192641139042325.davem@davemloft.net>
 <1427162890.4770.307.camel@kernel.crashing.org>
In-Reply-To: <1427162890.4770.307.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: aik@au1.ibm.com, aik@ozlabs.ru, sowmini.varadhan@oracle.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Mar 2015 13:08:10 +1100

> For the large pool, we don't keep a hint so we don't know it's
> wrapped, in fact we purposefully don't use a hint to limit
> fragmentation on it, but then, it should be used rarely enough that
> flushing always is, I suspect, a good option.

I can't think of any use case where the largepool would be hit a lot
at all.
