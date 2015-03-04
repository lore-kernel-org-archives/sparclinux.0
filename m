From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 04 Mar 2015 19:10:17 +0000
Subject: Re: [PATCH v2 0/2] sparc: IOMMU pools for better scalability
Message-Id: <20150304191017.GD4902@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150303142202.GA7696@oracle.com>
In-Reply-To: <20150303142202.GA7696@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (03/03/15 17:15), David Miller wrote:
> 
> For example, IOMMU_NUM_CTXS.
> 
> I don't see anything using cookie_to_index.
> 
> Furthermore, who so many TABS in the dma_4v_iommu_ops initializer?
> 
> Next, canonically "linux/" headers are included before "asm/" ones.

sure I can fix all of the above for v3. The cookie_to_index
comes from ldc_iommu conversion, which I had not added to the set
because it does nothing whatsoever for ldc perf, where we are only
dealing with an 8k map size, though I see the value of less code
duplication.

I'll add ldc to the v3 patch-set.

However..

> Please don't put "ifdef notyet" kind of stuff into your changes,
> that is not appropriate.  In any event, I want you to translate all
> of the PCI DMA implementations, because it is the only way you can
> show me that your abstractions are sufficient.

That means I have to fix all kinds of dinosaurs in the neighborhood,
things like pci_fire, pci_schizo, pci_psycho, sun4u. Some of this
hardware was EOL'ed a long time ago. And the last time I remember
using a sun4u was back in 2008 (and even then, it was really not
very useful for any sort of non-trivial SMP/perf development).

But whatever floats your boat. 

Just want to note that this will no longer be a simple 2-part patch set.

--Sowmini


