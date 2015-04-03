From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 03 Apr 2015 18:59:39 +0000
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
Message-Id: <20150403185939.GC10892@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1427857069-6789-2-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Tue, Mar 31, 2015 at 07:57:47PM -0700, Yinghai Lu wrote:
> David Ahern found commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows
> to fit in upstream windows") broke booting on sparc/T5-8.
> 
> In the boot log, there is
>   pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
>   0x110204000)
> but that only could happen when dma_addr_t is 32-bit.
> 
> According to David Miller, all DMA occurs behind an IOMMU and these
> IOMMUs only support 32-bit addressing, therefore dma_addr_t is
> 32-bit on sparc64.
> 
> Let's introduce pci_bus_addr_t instead of using dma_addr_t,
> and pci_bus_addr_t will be 64-bit on 64-bit platform or X86_PAE.

I propose the following doc updates (I can just fold them into this patch
if you approve):


commit 13fca18e2f1d9dd078b8dfea965718cf13a4b600
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Apr 3 12:39:35 2015 -0500

    pci-bus-addr-fixups

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index 0f7afb2bb442..aef8cc5a677b 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -25,13 +25,18 @@ physical addresses.  These are the addresses in /proc/iomem.  The physical
 address is not directly useful to a driver; it must use ioremap() to map
 the space and produce a virtual address.
 
-I/O devices use a third kind of address: a "bus address" or "DMA address".
-If a device has registers at an MMIO address, or if it performs DMA to read
-or write system memory, the addresses used by the device are bus addresses.
-In some systems, bus addresses are identical to CPU physical addresses, but
-in general they are not.  IOMMUs and host bridges can produce arbitrary
+I/O devices use a third kind of address: a "bus address".  If a device has
+registers at an MMIO address, or if it performs DMA to read or write system
+memory, the addresses used by the device are bus addresses.  In some
+systems, bus addresses are identical to CPU physical addresses, but in
+general they are not.  IOMMUs and host bridges can produce arbitrary
 mappings between physical and bus addresses.
 
+From a device's point of view, DMA uses the bus address space, but it may
+be restricted to a subset of that space.  For example, even if a system
+supports 64-bit addresses for main memory and PCI BARs, it may use an IOMMU
+so devices only need to use 32-bit DMA addresses.
+
 Here's a picture and some examples:
 
                CPU                  CPU                  Bus
@@ -72,11 +77,11 @@ can use virtual address X to access the buffer, but the device itself
 cannot because DMA doesn't go through the CPU virtual memory system.
 
 In some simple systems, the device can do DMA directly to physical address
-Y.  But in many others, there is IOMMU hardware that translates bus
+Y.  But in many others, there is IOMMU hardware that translates DMA
 addresses to physical addresses, e.g., it translates Z to Y.  This is part
 of the reason for the DMA API: the driver can give a virtual address X to
 an interface like dma_map_single(), which sets up any required IOMMU
-mapping and returns the bus address Z.  The driver then tells the device to
+mapping and returns the DMA address Z.  The driver then tells the device to
 do DMA to Z, and the IOMMU maps it to the buffer at address Y in system
 RAM.
 
@@ -98,7 +103,7 @@ First of all, you should make sure
 #include <linux/dma-mapping.h>
 
 is in your driver, which provides the definition of dma_addr_t.  This type
-can hold any valid DMA or bus address for the platform and should be used
+can hold any valid DMA address for the platform and should be used
 everywhere you hold a DMA address returned from the DMA mapping functions.
 
 			 What memory is DMA'able?
@@ -316,7 +321,7 @@ There are two types of DMA mappings:
   Think of "consistent" as "synchronous" or "coherent".
 
   The current default is to return consistent memory in the low 32
-  bits of the bus space.  However, for future compatibility you should
+  bits of the DMA space.  However, for future compatibility you should
   set the consistent mask even if this default is fine for your
   driver.
 
@@ -403,7 +408,7 @@ dma_alloc_coherent() returns two values: the virtual address which you
 can use to access it from the CPU and dma_handle which you pass to the
 card.
 
-The CPU virtual address and the DMA bus address are both
+The CPU virtual address and the DMA address are both
 guaranteed to be aligned to the smallest PAGE_SIZE order which
 is greater than or equal to the requested size.  This invariant
 exists (for example) to guarantee that if you allocate a chunk
@@ -645,8 +650,8 @@ PLEASE NOTE:  The 'nents' argument to the dma_unmap_sg call must be
               dma_map_sg call.
 
 Every dma_map_{single,sg}() call should have its dma_unmap_{single,sg}()
-counterpart, because the bus address space is a shared resource and
-you could render the machine unusable by consuming all bus addresses.
+counterpart, because the DMA address space is a shared resource and
+you could render the machine unusable by consuming all DMA addresses.
 
 If you need to use the same streaming DMA region multiple times and touch
 the data in between the DMA transfers, the buffer needs to be synced
diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 52088408668a..7eba542eff7c 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -18,10 +18,10 @@ Part I - dma_ API
 To get the dma_ API, you must #include <linux/dma-mapping.h>.  This
 provides dma_addr_t and the interfaces described below.
 
-A dma_addr_t can hold any valid DMA or bus address for the platform.  It
-can be given to a device to use as a DMA source or target.  A CPU cannot
-reference a dma_addr_t directly because there may be translation between
-its physical address space and the bus address space.
+A dma_addr_t can hold any valid DMA address for the platform.  It can be
+given to a device to use as a DMA source or target.  A CPU cannot reference
+a dma_addr_t directly because there may be translation between its physical
+address space and the DMA address space.
 
 Part Ia - Using large DMA-coherent buffers
 ------------------------------------------
@@ -42,7 +42,7 @@ It returns a pointer to the allocated region (in the processor's virtual
 address space) or NULL if the allocation failed.
 
 It also returns a <dma_handle> which may be cast to an unsigned integer the
-same width as the bus and given to the device as the bus address base of
+same width as the bus and given to the device as the DMA address base of
 the region.
 
 Note: consistent memory can be expensive on some platforms, and the
@@ -193,7 +193,7 @@ dma_map_single(struct device *dev, void *cpu_addr, size_t size,
 		      enum dma_data_direction direction)
 
 Maps a piece of processor virtual memory so it can be accessed by the
-device and returns the bus address of the memory.
+device and returns the DMA address of the memory.
 
 The direction for both APIs may be converted freely by casting.
 However the dma_ API uses a strongly typed enumerator for its
@@ -212,20 +212,20 @@ contiguous piece of memory.  For this reason, memory to be mapped by
 this API should be obtained from sources which guarantee it to be
 physically contiguous (like kmalloc).
 
-Further, the bus address of the memory must be within the
+Further, the DMA address of the memory must be within the
 dma_mask of the device (the dma_mask is a bit mask of the
-addressable region for the device, i.e., if the bus address of
-the memory ANDed with the dma_mask is still equal to the bus
+addressable region for the device, i.e., if the DMA address of
+the memory ANDed with the dma_mask is still equal to the DMA
 address, then the device can perform DMA to the memory).  To
 ensure that the memory allocated by kmalloc is within the dma_mask,
 the driver may specify various platform-dependent flags to restrict
-the bus address range of the allocation (e.g., on x86, GFP_DMA
-guarantees to be within the first 16MB of available bus addresses,
+the DMA address range of the allocation (e.g., on x86, GFP_DMA
+guarantees to be within the first 16MB of available DMA addresses,
 as required by ISA devices).
 
 Note also that the above constraints on physical contiguity and
 dma_mask may not apply if the platform has an IOMMU (a device which
-maps an I/O bus address to a physical memory address).  However, to be
+maps an I/O DMA address to a physical memory address).  However, to be
 portable, device driver writers may *not* assume that such an IOMMU
 exists.
 
@@ -296,7 +296,7 @@ reduce current DMA mapping usage or delay and try again later).
 	dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction direction)
 
-Returns: the number of bus address segments mapped (this may be shorter
+Returns: the number of DMA address segments mapped (this may be shorter
 than <nents> passed in if some elements of the scatter/gather list are
 physically or virtually adjacent and an IOMMU maps them with a single
 entry).
@@ -340,7 +340,7 @@ must be the same as those and passed in to the scatter/gather mapping
 API.
 
 Note: <nents> must be the number you passed in, *not* the number of
-bus address entries returned.
+DMA address entries returned.
 
 void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
@@ -507,7 +507,7 @@ it's asked for coherent memory for this device.
 phys_addr is the CPU physical address to which the memory is currently
 assigned (this will be ioremapped so the CPU can access the region).
 
-device_addr is the bus address the device needs to be programmed
+device_addr is the DMA address the device needs to be programmed
 with to actually address this memory (this will be handed out as the
 dma_addr_t in dma_alloc_coherent()).
 
diff --git a/include/linux/types.h b/include/linux/types.h
index 6747247e3f9f..00a127e89752 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -139,12 +139,20 @@ typedef unsigned long blkcnt_t;
  */
 #define pgoff_t unsigned long
 
-/* A dma_addr_t can hold any valid DMA or bus address for the platform */
+/*
+ * A dma_addr_t can hold any valid DMA address, i.e., any address returned
+ * by the DMA API.
+ *
+ * If the DMA API only uses 32-bit addresses, dma_addr_t need only be 32
+ * bits wide.  Bus addresses, e.g., PCI BARs, may be wider than 32 bits,
+ * but drivers do memory-mapped I/O to ioremapped kernel virtual addresses,
+ * so they don't care about the size of the actual bus addresses.
+ */
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 typedef u64 dma_addr_t;
 #else
 typedef u32 dma_addr_t;
-#endif /* dma_addr_t */
+#endif
 
 #ifdef __CHECKER__
 #else
