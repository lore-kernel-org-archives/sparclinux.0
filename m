From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 10 Nov 2015 22:27:07 +0000
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Message-Id: <1447194427.31884.100.camel@kernel.crashing.org>
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
	<CALCETrVkE3=KCxK-_bf-P8UfTS96Vck+QPE8EsLvP7THxpLe1A@mail.gmail.com>
In-Reply-To: <CALCETrVkE3=KCxK-_bf-P8UfTS96Vck+QPE8EsLvP7THxpLe1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S.
	Miller" <davem@davemloft.net>

On Tue, 2015-11-10 at 10:54 -0800, Andy Lutomirski wrote:
>=C2=A0
> Does that work on powerpc on existing kernels?
>=20
> Anyway, here's another crazy idea: make the quirk assume that the
> IOMMU is bypasses if and only if the weak barriers bit is set on
> systems that are missing the new DT binding.

"New DT bindings" doesn't mean much ... how do we change DT bindings on
existing machines with a FW in flash ?

What about partition <-> partition virtio such as what we could do on
PAPR systems. That would have the weak barrier bit.

Ben.

