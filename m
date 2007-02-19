From: David Miller <davem@davemloft.net>
Date: Mon, 19 Feb 2007 08:31:48 +0000
Subject: Re: virt_irq_{alloc,free} inconsistency with no MSI
Message-Id: <20070219.003148.63109019.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0702161227260.3144@math>
In-Reply-To: <Pine.SOC.4.64.0702161227260.3144@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 16 Feb 2007 12:30:56 +0200 (EET)

> While investigating this (with current -git for sun4u and no 
> CONFIG_PCI_MSI)
> 
>   CC      arch/sparc64/kernel/irq.o
> cc1: warnings being treated as errors
> arch/sparc64/kernel/irq.c:113: warning: 'virt_irq_free' defined but not used
> 
> I found that virt_irq_free() is used only if CONFIG_PCI_MSI is defined 
> (for sun4v - simple to cure with a define), but virt_irq_alloc() is used 
> even without MSI enabled. Is this really correct? Do we alloc and not 
> free it in this case?

Yes, it is true :-)  We allocate all the interrupts needed for the
entire system as we probe the busses and devices.

But with MSI, the MSI vectors are allocated and liberated with
pci_enable_msi()/pci_disable_msi() and related calls.

I'll add the necessary ifdefs, thanks for the report.
