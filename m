From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed, 18 Nov 2009 08:45:41 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific mmu_inval_dma_area
Message-Id: <4B03B435.9010607@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

> 
> You really need to investigate why dma_map_single() is not
> returning sane addresses.

I haven't reached a conclusion yet since I'm not so familiar with
the Linux VM subsystem and have not had much time to look at it.

But I noticed that pci_map_single does not work in later kernels.
I guess it stopped working with the patch "sparc: Use
asm-generic/pci-dma-compat" since before the that the physical address
was obtained through virt_to_phys() and after that it goes through
page_to_phys(virt_to_page()) which does not work. Using
page_address(virt_to_page()) works but I understand that this does not
always evaluate properly.

Using page_to_phys(virt_to_page()) results in an address lacking the
phys_base offset. My patch to page_to_phys (adding phys_base) several
weeks ago was done because of this but I thought that the problem then
was that I was using virt_to_page() on an address obtained through
kmalloc which I have read is not really allowed?
The page_to_phys(virt_to_page()) does not even work for memory allocated
with __get_free_page() currently.

I will continue investigating this when I have the time. I just wanted
to give you this feedback. Maybe you understand what is going on ...

Best regards,
Kristoffer






