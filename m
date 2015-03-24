From: David Miller <davem@davemloft.net>
Date: Tue, 24 Mar 2015 01:44:53 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150323.214453.255192641139042325.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
 <1427149265.4770.238.camel@kernel.crashing.org>
In-Reply-To: <1427149265.4770.238.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: aik@au1.ibm.com, aik@ozlabs.ru, sowmini.varadhan@oracle.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Mar 2015 09:21:05 +1100

> Dave, what's your feeling there ? Does anybody around still have
> some HW that we can test with ?

I don't see what the actual problem is.

Even if you use multiple pools, which we should for scalability on
sun4u too, just do the flush when allocation in _any_ pool wraps
around.

That's still better than not doing the optimization at all.

That is always going to be correct, and you can use a separate
spinlock to make sure only one thread of control does the full
IOMMU flush at a time.
