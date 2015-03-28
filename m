From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 28 Mar 2015 02:07:32 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <CAE9FiQVHwR7ge-hFXq=xqOTZEzHdm5AqiwFC3HEcrTKxeDcePg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>
	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
	<551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
	<20150328010532.GA15897@ravnborg.org>
In-Reply-To: <20150328010532.GA15897@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Ahern <david.ahern@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Mar 27, 2015 at 6:05 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> Index: linux-2.6/arch/alpha/Kconfig
>> =================================>> --- linux-2.6.orig/arch/alpha/Kconfig
>> +++ linux-2.6/arch/alpha/Kconfig
>> @@ -66,6 +66,9 @@ config ZONE_DMA
>>  config ARCH_DMA_ADDR_T_64BIT
>>       def_bool y
>>
>> +config ARCH_PCI_BUS_ADDR_T_64BIT
>> +     def_bool y
>> +
> For alpha you define a new symbol with a default value.
>
>>  config NEED_DMA_MAP_STATE
>>         def_bool y
>>
>> Index: linux-2.6/arch/arm/Kconfig
>> =================================>> --- linux-2.6.orig/arch/arm/Kconfig
>> +++ linux-2.6/arch/arm/Kconfig
>> @@ -1779,6 +1779,7 @@ config XEN
>>       depends on !GENERIC_ATOMIC64
>>       depends on MMU
>>       select ARCH_DMA_ADDR_T_64BIT
>> +     select ARCH_PCI_BUS_ADDR_T_64BIT
>>       select ARM_PSCI
>>       select SWIOTLB_XEN
>>       help
> For arm you use select ...
>
> As the actual definition of the Kconfig symbol is already
> present in mm/Kconfig please use select in all cases.
>
>> Index: linux-2.6/arch/arm/mm/Kconfig
>> =================================>> --- linux-2.6.orig/arch/arm/mm/Kconfig
>> +++ linux-2.6/arch/arm/mm/Kconfig
>> @@ -630,6 +630,9 @@ config ARCH_PHYS_ADDR_T_64BIT
>>  config ARCH_DMA_ADDR_T_64BIT
>>       bool
>>
>> +config ARCH_PCI_BUS_ADDR_T_64BIT
>> +     bool
>> +
> Here it would have been nice with a comment that explains the use of ths symbol.

just duplicate the ARCH_DMA_ADDR_T_64BIT above

>
>>  config ARM_THUMB
>>       bool "Support Thumb user binaries" if !CPU_THUMBONLY
>>       depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || \
>> Index: linux-2.6/arch/arm64/Kconfig
>> =================================>> --- linux-2.6.orig/arch/arm64/Kconfig
>> +++ linux-2.6/arch/arm64/Kconfig
>> @@ -125,6 +125,9 @@ config HAVE_GENERIC_RCU_GUP
>>  config ARCH_DMA_ADDR_T_64BIT
>>       def_bool y
>>
>> +config ARCH_PCI_BUS_ADDR_T_64BIT
>> +     def_bool y
>> +
> Use select
...

I was trying to keep the style to be consistent with old one in each Kconfig.

So do we just need to make sure new added lines to use new style?


>
>> Index: linux-2.6/include/linux/types.h
>> =================================>> --- linux-2.6.orig/include/linux/types.h
>> +++ linux-2.6/include/linux/types.h
>> @@ -146,6 +146,13 @@ typedef u64 dma_addr_t;
>>  typedef u32 dma_addr_t;
>>  #endif /* dma_addr_t */
>>
>> +/* A pci_bus_addr_t can hold pci bus address for the platform */
>> +#ifdef CONFIG_ARCH_PCI_BUS_ADDR_T_64BIT
>> +typedef u64 pci_bus_addr_t;
>> +#else
>> +typedef u32 pci_bus_addr_t;
>> +#endif /* pci_bus_addr_t */
>> +
> Looking att all the Kconfig logic I get the impression that
> the type of pci_bus_addr_t equals unsigned long.
> If this is correct then you can skip that and things
> gets much simpler.

For x86 32bit with PAE support, we could use 64bit for bus address.
but unsigned long is 32bit.

Thanks

Yinghai
