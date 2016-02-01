From: Wei Liu <wei.liu2@citrix.com>
Date: Mon, 01 Feb 2016 11:00:57 +0000
Subject: Re: [Xen-devel] [PATCH v5 00/10] virtio DMA API, yet again
Message-Id: <20160201110057.GC10990@citrix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
In-Reply-To: <cover.1454034075.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, wei.liu2@citrix.com, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, David Vrabel <david.vrabel@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>

Nice work, Andy.

On Thu, Jan 28, 2016 at 06:31:13PM -0800, Andy Lutomirski wrote:
> This switches virtio to use the DMA API on Xen and if requested by
> module option.
> 
> This fixes virtio on Xen, and it should break anything because it's
> off by default on everything except Xen PV on x86.
> 

What is your setup? My understanding is that virtio doesn't work on PV
guest as of now because a suitable transport is missing.

Wei.
