From: Helge Deller <deller@gmx.de>
Date: Tue, 18 Aug 2015 19:47:50 +0000
Subject: Re: Aw: A500 boot crash in 4.2.0-rc3-00246-g763e326
Message-Id: <55D38BE6.6080302@gmx.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1507260929000.30065@math.ut.ee>
 <trinity-122a736f-3aac-4830-afc5-2abcd91792ea-1439820380917@3capp-gmx-bs71>
 <trinity-5720bef8-5a4c-4465-b9eb-622daaef650a-1439902901415@3capp-gmx-bs02>
 <alpine.LRH.2.20.1508182141200.24742@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1508182141200.24742@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>, Yinghai Lu <yinghai@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-pci@vger.kernel.org, David Ahern <david.ahern@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, sparclinux@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>

On 18.08.2015 20:44, Meelis Roos wrote:
> (CC-s added)
>
>>>> Tried 4.2.0-rc3-00246-g763e326 on A500 but it crashes on boot. This is
>>>> still present in todays 4.2.0-rc6+git. 4.1 was fine, I Will bisect but
>>>> it takes time.
>>>>
>>>> PDC Stable Storage facility v0.30
>>>> STI GSC/PCI core graphics driver Version 0.9b
>>>> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>>>> serial 0000:00:04.0: enabling device (0146 -> 0147)
>>>> console [ttyS0] disabled
>>>> 0000:00:04.0: ttyS0 at MMIO 0xfffffffff8000000 (irq = 21, base_baud = 115200) is a 16550A
>>>> console [ttyS0] enabled
>>>> console [ttyS0] enabled
>>>> bootconsole [ttyB0] disabled
>>>> bootconsole [ttyB0] disabled
>>>> 0000:00:04.0: ttyS1 at MMIO 0xfffffffff8000008 (irq = 21, base_baud = 115200) is a 16550A
>>>> 0000:00:04.0: ttyS2 at MMIO 0xfffffffff8000010 (irq = 21, base_baud = 115200) is a 16550A
>>>> serial 0000:00:05.0: enabling device (0000 -> 0003)
>>>> serial 0000:00:05.0: enabling SERR and PARITY (0003 -> 0143)
>>>> 0000:00:05.0: ttyS3 at MMIO 0xfffffffff8003000 (irq = 22, base_baud = 115200) is a 16550A
>>>> serial 0000:00:05.0: Couldn't register serial port 0, irq 22, type 2, error -28
>>>> sym53c8xx 0000:00:01.0: enabling device (0000 -> 0003)
>>>> sym53c8xx 0000:00:01.0: enabling SERR and PARITY (0003 -> 0143)
>>>
>>> I'm seeing the same problem on my rp5470 with Kernel 4.2-rc7. My machine just hangs though and doesn't crash.
>>
>> I did a bisect and commit 3a9ad0b4fdcd57f775d3615004c8c64c021a9e7d ("PCI: Add pci_bus_addr_t") seems to be the culprit:
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id:9ad0b4fdcd57f775d3615004c8c64c021a9e7d
>>
>> Since the patch has "CC: stable@vger.kernel.org  # v3.19+", it might be the reason why you see kernel 3.19 failing too...
>
> I just found the same commit breaking my A500 parisc machine by
> bisecting.
>
> CC: patch author and linux-pci.

I think this is the problem:

--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -1,6 +1,10 @@
  #
  # PCI configuration
  #
+config PCI_BUS_ADDR_T_64BIT
+       def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
+       depends on PCI


CONFIG_PCI_BUS_ADDR_T_64BIT gets now defined on all 64bit arches.
Then if CONFIG_PCI_BUS_ADDR_T_64BIT is set, in pci_bus_alloc_resource()
64bit address spaces (IORESOURCE_MEM_64) will be enabled which weren't enabled before.

This trivial/temporary hack fixes the problem:

--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -200,7 +200,7 @@ int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
                                           resource_size_t),
                 void *alignf_data)
  {
-#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
+#if defined(CONFIG_PCI_BUS_ADDR_T_64BIT) && !defined(CONFIG_PARISC)
         int rc;
  
         if (res->flags & IORESOURCE_MEM_64) {


but the real problem is probably, that the sym53c8xx driver or maybe the parisc PCI core code isn't 64bit clean?

I did some more debugging, and on parisc the first hang happens in function sym_check_raid() [called from sym2_probe()]
indrivers/scsi/sym53c8xx_2/sym_glue.c while trying to call readl():
   ram_val = readl(device->s.ramaddr + ram_size - 16);

Helge
