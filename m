From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 28 Jul 2004 15:01:30 +0000
Subject: Re: Build error due to pci_dma_mapping_error duplication
Message-Id: <20040728150130.GW2334@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040728145140.GV3996@artsapartment.org>
In-Reply-To: <20040728145140.GV3996@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jul 28, 2004 at 09:51:40AM -0500, Art Haas wrote:
> I tried building the BK kernel a day or two ago on my SS20, and things
> failed due to the following error:
> include/asm/pci.h:160: error: redefinition of `pci_dma_mapping_error'
> include/asm/pci.h:92: error: `pci_dma_mapping_error' previously defined
> here
> It seems pcm_dma_mapping_error() is duplicated in this header file.
> The first instance reads as follows:
> static inline int pci_dma_mapping_error(dma_addr_t dma_addr)
> {
>         return 0;
> }
> The second, and the newly added version in the 1.15->1.16 change to the
> file is:
> static inline int pci_dma_mapping_error(dma_addr_t dma_addr)
> {
>         return (dma_addr = PCI_DMA_ERROR_CODE);
> }
> I'd guess the first one needs to go. Correct?

Yes, please send that in ASAP.

-- wli
