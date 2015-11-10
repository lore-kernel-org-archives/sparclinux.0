From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 10 Nov 2015 19:37:38 +0000
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Message-Id: <1447184258.31884.91.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
	<CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
	<1447133316.31884.67.camel@kernel.crashing.org>
	<CALCETrVPQc04Ah7FXcRMb4RhpUJ1WPCoC_4dbacB8a+u5XpmwA@mail.gmail.com>
	<1447151874.31884.82.camel@kernel.crashing.org>
	<20151110142633-mutt-send-email-mst@redhat.com>
In-Reply-To: <20151110142633-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Andy Lutomirski <luto@kernel.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S.
	Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Tue, 2015-11-10 at 14:43 +0200, Michael S. Tsirkin wrote:
> But not virtio-pci I think - that's broken for that usecase since we use
> weaker barriers than required for real IO, as these have measureable
> overhead.  We could have a feature "is a real PCI device",
> that's completely reasonable.

Do we use weaker barriers on the Linux driver side ? I didn't think so
... 

Cheers,
Ben.

