From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 09 Nov 2015 22:58:57 +0000
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Message-Id: <1447109937.31884.42.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
In-Reply-To: <20151109133624-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andy Lutomirski <luto@kernel.org>, dwmw2@infradead.org
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>

So ...

I've finally tried to sort that out for powerpc and I can't find a way
to make that work that isn't a complete pile of stinking shit.

I'm very tempted to go back to my original idea: virtio itself should
indicate it's "bypassing ability" via the virtio config space or some
other bit (like the ProgIf of the PCI header etc...).

I don't see how I can make it work otherwise.

The problem with the statement "it's a platform matter" is that:

  - It's not entirely correct. It's actually a feature of a specific
virtio implementation (qemu's) that it bypasses all the platform IOMMU
facilities.

  - The platforms (on powerpc there's at least 3 or 4 that have qemu
emulation and support some form of PCI) don't have an existing way to
convey the information that a device bypasses the IOMMU (if any).

  - Even if we add such a mechanism (new property in the device-tree),
we end up with a big turd: Because we need to be compatible with older
qemus, we essentially need a quirk that will make all virtio devices
assume that property is present. That will of course break whenever we
try to use another implementation of virtio on powerpc which doesn't
bypass the iommu.

We don't have a way to differenciate a virtio device that does the
bypass from one that doesn't and the backward compatibility requirement
forces us to treat all existing virtio devices as doing bypass.

The only way out of this while keeping the "platform" stuff would be to
also bump some kind of version in the virtio config (or PCI header). I
have no other way to differenciate between "this is an old qemu that
doesn't do the 'bypass property' yet" from "this is a virtio device
that doesn't bypass".

Any better idea ?

Cheers,
Ben.


