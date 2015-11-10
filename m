From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 10 Nov 2015 10:37:54 +0000
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Message-Id: <1447151874.31884.82.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
	<CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
	<1447133316.31884.67.camel@kernel.crashing.org>
	<CALCETrVPQc04Ah7FXcRMb4RhpUJ1WPCoC_4dbacB8a+u5XpmwA@mail.gmail.com>
In-Reply-To: <CALCETrVPQc04Ah7FXcRMb4RhpUJ1WPCoC_4dbacB8a+u5XpmwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Mon, 2015-11-09 at 21:35 -0800, Andy Lutomirski wrote:
> 
> We could do it the other way around: on powerpc, if a PCI device is in
> that range and doesn't have the "bypass" property at all, then it's
> assumed to bypass the IOMMU.  This means that everything that
> currently works continues working.  If someone builds a physical
> virtio device or uses another system in PCIe target mode speaking
> virtio, then it won't work until they upgrade their firmware to set
> bypass=0.  Meanwhile everyone using hypothetical new QEMU also gets
> bypass=0 and no ambiguity.
>
> vfio will presumably notice the bypass and correctly refuse to map any
> current virtio devices.
> 
> Would that work?

That would be extremely strange from a platform perspective. Any device
in that vendor/device range would bypass the iommu unless some new
property "actually-works-like-a-real-pci-device" happens to exist in
the device-tree, which we would then need to define somewhere and
handle accross at least 3 different platforms who get their device-tree 
from widly different places.

Also if tomorrow I create a PCI device that implements virtio-net and
put it in a machine running IBM proprietary firmware (or Apple's or
Sun's), it won't have that property...

This is not hypothetical. People are using virtio to do point-to-point
communication between machines via PCIe today.

Cheers,
Ben.


