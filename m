From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 30 Oct 2015 01:17:02 +0000
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Message-Id: <CALCETrWP14E9k=BKhhm3CJZmM_W9CYt77W0m29BtzigZucSu5g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1446162273.git.luto@kernel.org>
In-Reply-To: <cover.1446162273.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Thu, Oct 29, 2015 at 6:09 PM, Andy Lutomirski <luto@kernel.org> wrote:
> This switches virtio to use the DMA API unconditionally.  I'm sure
> it breaks things, but it seems to work on x86 using virtio-pci, with
> and without Xen, and using both the modern 1.0 variant and the
> legacy variant.

...

> Andy Lutomirski (5):
>   virtio_ring: Support DMA APIs
>   virtio_pci: Use the DMA API
>   virtio: Add improved queue allocation API
>   virtio_mmio: Use the DMA API
>   virtio_pci: Use the DMA API

Ugh.  The two virtio_pci patches should be squashed together.  I'll do
that for v5, but I'm not going to send it until there's more feedback.

FWIW, I'm collecting this stuff here:

https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=virtio_dma

That branch includes this series (with the squash) and the s390
patches.  I'll keep it up to date, since it seems silly to declare it
stable enough to stop rebasing yet.

--Andy
