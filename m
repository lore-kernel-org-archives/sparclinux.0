From: Wei Liu <wei.liu2@citrix.com>
Date: Mon, 01 Feb 2016 21:22:57 +0000
Subject: Re: [Xen-devel] [PATCH v5 00/10] virtio DMA API, yet again
Message-Id: <20160201212257.GA9803@citrix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
	<20160201110057.GC10990@citrix.com>
	<CALCETrU4tJ0pta96tvmuUYB_hKF8_2+bYOZ-qrFTytyXfDchXQ@mail.gmail.com>
In-Reply-To: <CALCETrU4tJ0pta96tvmuUYB_hKF8_2+bYOZ-qrFTytyXfDchXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu2@citrix.com>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Mon, Feb 01, 2016 at 10:04:07AM -0800, Andy Lutomirski wrote:
> On Mon, Feb 1, 2016 at 3:00 AM, Wei Liu <wei.liu2@citrix.com> wrote:
> > Nice work, Andy.
> >
> > On Thu, Jan 28, 2016 at 06:31:13PM -0800, Andy Lutomirski wrote:
> >> This switches virtio to use the DMA API on Xen and if requested by
> >> module option.
> >>
> >> This fixes virtio on Xen, and it should break anything because it's
> >> off by default on everything except Xen PV on x86.
> >>
> >
> > What is your setup? My understanding is that virtio doesn't work on PV
> > guest as of now because a suitable transport is missing.
> 
> I cheated and ran Xen under KVM with the virtio-pci device provided by
> QEMU.   If you have virtme
> (https://git.kernel.org/cgit/utils/kernel/virtme/virtme.git/), you can
> do:
> 

Thanks for the clarification. This is exactly what I needed to know.  In
that case virtio-pci transport is used.  All virtio devices are exposed
as PCI devices.

Wei.


> virtme-run --kdir=. --pwd --xen xen-4.5.2 --qemu-opts -smp 3 -m 1024
> 
> where xen-4.5.2 is the gunzipped Xen binary.  (Other versions work, too.)
> 
> --Andy
