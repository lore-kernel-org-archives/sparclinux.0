From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 04 Apr 2015 03:40:46 +0000
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
Message-Id: <CAE9FiQX6Q4nPqZbCTfO+=obv6EGpeV4LRU-LkSsFWZQOaxOMrw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<1427857069-6789-2-git-send-email-yinghai@kernel.org>
	<20150403185939.GC10892@google.com>
In-Reply-To: <20150403185939.GC10892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Fri, Apr 3, 2015 at 11:59 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Mar 31, 2015 at 07:57:47PM -0700, Yinghai Lu wrote:
>> David Ahern found commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows
>> to fit in upstream windows") broke booting on sparc/T5-8.
>>
>> In the boot log, there is
>>   pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
>>   0x110204000)
>> but that only could happen when dma_addr_t is 32-bit.
>>
>> According to David Miller, all DMA occurs behind an IOMMU and these
>> IOMMUs only support 32-bit addressing, therefore dma_addr_t is
>> 32-bit on sparc64.
>>
>> Let's introduce pci_bus_addr_t instead of using dma_addr_t,
>> and pci_bus_addr_t will be 64-bit on 64-bit platform or X86_PAE.
>
> I propose the following doc updates (I can just fold them into this patch
> if you approve):
>
>
> commit 13fca18e2f1d9dd078b8dfea965718cf13a4b600
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Apr 3 12:39:35 2015 -0500
>
>     pci-bus-addr-fixups
>
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 6747247e3f9f..00a127e89752 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -139,12 +139,20 @@ typedef unsigned long blkcnt_t;
>   */
>  #define pgoff_t unsigned long
>
> -/* A dma_addr_t can hold any valid DMA or bus address for the platform */
> +/*
> + * A dma_addr_t can hold any valid DMA address, i.e., any address returned
> + * by the DMA API.
> + *
> + * If the DMA API only uses 32-bit addresses, dma_addr_t need only be 32
> + * bits wide.  Bus addresses, e.g., PCI BARs, may be wider than 32 bits,
> + * but drivers do memory-mapped I/O to ioremapped kernel virtual addresses,
> + * so they don't care about the size of the actual bus addresses.
> + */

Good to me.

Thanks

Yinghai
