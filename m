From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 10 Nov 2015 05:28:36 +0000
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Message-Id: <1447133316.31884.67.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
	<CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
In-Reply-To: <CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Mon, 2015-11-09 at 18:18 -0800, Andy Lutomirski wrote:
> 
> /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF.
> */
> static const struct pci_device_id virtio_pci_id_table[] = {
>         { PCI_DEVICE(0x1af4, PCI_ANY_ID) },
>         { 0 }
> };
> 
> Can we match on that range?

We can, but the problem remains, how do we differenciate an existing
device that does bypass vs. a newer one that needs the IOMMU and thus
doesn't have the new "bypass" property in the device-tree.

Cheers,
Ben.

