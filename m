From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 01 Feb 2016 13:23:24 +0000
Subject: Re: [PATCH v5 04/10] vring: Introduce vring_use_dma_api()
Message-Id: <20160201133556-mutt-send-email-mst@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
	<cab70812b0a46a5a5b36e6de4110c5c66a6f6916.1454034075.git.luto@kernel.org>
	<1454325723.133285.285.camel@infradead.org>
In-Reply-To: <1454325723.133285.285.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Mon, Feb 01, 2016 at 11:22:03AM +0000, David Woodhouse wrote:
> On Thu, 2016-01-28 at 18:31 -0800, Andy Lutomirski wrote:
> > This is a kludge, but no one has come up with a a better idea yet.
> > We'll introduce DMA API support guarded by vring_use_dma_api().
> > Eventually we may be able to return true on more and more systems,
> > and hopefully we can get rid of vring_use_dma_api() entirely some
> > day.
> > 
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >  drivers/virtio/virtio_ring.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index e12e385f7ac3..4b8dab4960bb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -25,6 +25,30 @@
> >  #include 
> >  #include 
> >  
> > +/*
> > + * The interaction between virtio and a possible IOMMU is a mess.
> > + *
> > + * On most systems with virtio, physical addresses match bus addresses,
> > + * and it doesn't particularly matter whether we use the DMI API.
> > + *
> > + * On some sytems, including Xen and any system with a physical device
> > + * that speaks virtio behind a physical IOMMU, we must use the DMA API
> > + * for virtio DMA to work at all.
> > + *
> > + * On other systems, including SPARC and PPC64, virtio-pci devices are
> > + * enumerated as though they are behind an IOMMU, but the virtio host
> > + * ignores the IOMMU, so we must either pretend that the IOMMU isn't
> > + * there or somehow map everything as the identity.
> > + *
> > + * For the time being, we preseve historic behavior and bypass the DMA
> > + * API.
> > + */
> 
> I spot at least three typos in there, FWIW. ('DMI API', 'sytems',
> 'preseve').

Good catch, hopefully will be fixed in v2.

> > +static bool vring_use_dma_api(void)
> > +{
> > +	return false;
> > +}
> > +
> 
> I'd quite like to see this be an explicit opt-out for the known-broken
> platforms. We've listed the SPARC and PPC64 issues. For x86 I need to
> refresh my memory as a prelude to trying to fix it... was the issue
> *just* that Qemu tends to ship with a broken BIOS that misdescribes the
> virtio devices (and any assigned PCI devices) as being behind an IOMMU
> when they're not, in the rare case that Qemu actually exposes its
> partially-implemented virtual IOMMU to the guest?
> 
> Could we have an arch_vring_eschew_dma_api(dev) function which the
> affected architectures could provide (as a prelude to fixing it so that
> the DMA API does the right thing for *itself*)?

I'm fine with this.

> It would be functionally equivalent, but it would help to push the
> workarounds to the right place — rather than entrenching them for ever
> in tricky "OMG we need to audit what all the architectures do... let's
> not touch it!" code.
> 
> -- 
> David Woodhouse                            Open Source Technology Centre
> David.Woodhouse@intel.com                              Intel Corporation
> 


