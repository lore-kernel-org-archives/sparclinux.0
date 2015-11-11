From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Nov 2015 05:08:33 +0000
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Message-Id: <1447218513.31884.144.camel@kernel.crashing.org>
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
	<1447194427.31884.100.camel@kernel.crashing.org>
	<CALCETrWb9poeyxXhcbAbQkpcP-XYjWtz2w9iSPkKJH8rdzAj-A@mail.gmail.com>
	<1447202682.31884.123.camel@kernel.crashing.org>
	<CALCETrWAVOATcCaUabunjYd+NYM1HRqJXG9K=DgrZCnBbWCexw@mail.gmail.com>
In-Reply-To: <CALCETrWAVOATcCaUabunjYd+NYM1HRqJXG9K=DgrZCnBbWCexw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>

On Tue, 2015-11-10 at 20:46 -0800, Andy Lutomirski wrote:
> Me neither.  At least it wouldn't be a regression, but it's still
> crappy.
> 
> I think that arm is fine, at least.  I was unable to find an arm QEMU
> config that has any problems with my patches.

Ok, give me a few days for my headache & fever to subside see if I can
find something better. David, no idea from your side ? :-)

Cheers,
Ben.

