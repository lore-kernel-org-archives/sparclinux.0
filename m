From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Mar 2015 00:48:58 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <1427158138.4770.296.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
 <1427150202.4770.248.camel@kernel.crashing.org>
 <20150323231943.GC21966@oracle.com>
In-Reply-To: <20150323231943.GC21966@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>

On Mon, 2015-03-23 at 19:19 -0400, Sowmini Varadhan wrote:

> What I've tried to do is to have a bool large_pool arg passed
> to iommu_tbl_pool_init. In my observation (instrumented for scsi, ixgbe), 
> we never allocate more than 4 pages at a time, so I pass in 
> large_pool = false for all the sparc platforms. 

But that might not be necessary. If indeed we very rarely use the large
pool, then just make it flush always. My feeling is that it will only
ever be used at driver init/remove time when allocating things like
descriptor rings, where the flush overhead dont' matter.

> > Or we can decide that large allocs are rare (typically
> > pci_alloc_consistent, ie, driver init time), and thus always flush on
> > them (or rather on free of a large chunk). David, what's your take
> > there ? I have a feeling that should work fine without a noticeable
> > performance issue...
> > 
> > I would also keep a "dirty" flag set on any free and cleared on any
> > flush to avoid more spurrious flushes, but here too the benefit might be
> > in the noise.

Ben.


