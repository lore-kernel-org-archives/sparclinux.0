From: Christoph Hellwig <hch@lst.de>
Date: Sun, 31 Jan 2016 19:06:16 +0000
Subject: Re: [PATCH v5 00/10] virtio DMA API, yet again
Message-Id: <20160131190616.GA15840@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
	<1454065260.133285.107.camel@infradead.org>
In-Reply-To: <1454065260.133285.107.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Fri, Jan 29, 2016 at 11:01:00AM +0000, David Woodhouse wrote:
> Also, wasn't Christoph looking at making per-device DMA ops more
> generic instead of an 'archdata' thing on basically every platform? Or
> did I just imagine that part?

What I've done for 4.5 is to switch all architectures to use DMA ops.
This should make it fairly easy to have a generic dma ops pointer in the
devie structure, but I have no need for that yet, and thus no short term
plans to do that work myself.
