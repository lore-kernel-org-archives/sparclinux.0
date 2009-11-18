From: David Miller <davem@davemloft.net>
Date: Wed, 18 Nov 2009 09:32:46 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20091118.013246.24143194.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed, 18 Nov 2009 09:45:41 +0100

> But I noticed that pci_map_single does not work in later kernels.
> I guess it stopped working with the patch "sparc: Use
> asm-generic/pci-dma-compat" since before the that the physical address
> was obtained through virt_to_phys() and after that it goes through
> page_to_phys(virt_to_page()) which does not work. Using
> page_address(virt_to_page()) works but I understand that this does not
> always evaluate properly.

"page_address(virt_to_page())" returns a virtual address, whereas
page_to_phys(virt_to_page()) returns a physical one.

> Using page_to_phys(virt_to_page()) results in an address lacking the
> phys_base offset.

If it's not adding in phys_base, then it's not returning a legal
physical address.  Any idea why we don't add phys_base here?  I feel
like we've discussed this exactly recently, like in the past few
months.
