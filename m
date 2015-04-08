From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 08 Apr 2015 21:12:07 +0000
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <1428527527.18187.28.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	 <1427857069-6789-4-git-send-email-yinghai@kernel.org>
	 <20150406220638.GH10892@google.com>
	 <20150406.203533.1356187749826485194.davem@davemloft.net>
	 <CAErSpo7zvqft2frrwCd5AKMSO1LB7=7Ys9stKsj7OGzkQv4K1Q@mail.gmail.com>
	 <20150408154759.GN10892@google.com>
In-Reply-To: <20150408154759.GN10892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>, Yinghai Lu <yinghai@kernel.org>, David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Wed, 2015-04-08 at 10:47 -0500, Bjorn Helgaas wrote:

> Based on Ben's concerns, I dropped Yinghai's three patches for now:
> 
>   PCI: Add pci_bus_addr_t
>   sparc/PCI: Parse 64-bit host bridge windows from OF
>   PCI: Allow non-prefetchable PCIe BARs in prefetchable windows
> 
> and reverted d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in
> upstream windows") instead.
> 
> I pushed this to my for-linus branch, which I intend to merge for v4.0.
> You can browse it here to see if you agree:

Thanks Bjorn. We can fix Yinghai patch for 4.2, it would be indeed handy
even for us to be able to support putting 64-bit NP BARs in prefetch
windows (For some SR-IOV adapters for example) too, but we need to do it
right.

Cheers,
Ben.


