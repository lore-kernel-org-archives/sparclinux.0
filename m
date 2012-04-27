From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 27 Apr 2012 18:29:35 +0000
Subject: Re: [PATCH] sparc64: Use node local allocations for IRQ stacks.
Message-Id: <20120427182935.GA5690@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120426.235507.1967848292117984225.davem@davemloft.net>
In-Reply-To: <20120426.235507.1967848292117984225.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Apr 27, 2012 at 02:08:40PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 27 Apr 2012 19:58:16 +0200
> 
> > On Fri, Apr 27, 2012 at 01:34:07PM -0400, David Miller wrote:
> >> > Knowing that sparc64 just got converted to NO_BOOTMEM it
> >> > hurts my eyes to see memblock_alloc() be replaced
> >> > by __alloc_bootmem_node().
> >> 
> >> Since the stack allocations happen now (for the sake of setting
> >> up the NUMA mappings) after bootmem init, it's prudent to use
> >> the alloc_bootmem interfaces.
> > 
> > It was my understanding that everything provided by mm/nobootmem.c
> > is wrappers provided for backward compatibility with the old
> > bootmem based early allocator.
> > And that we later would make this file optional when.
> > 
> > But I seems to be wrong here.
> 
> Once the memblock functions provide NUMA node fallbacks and
> __va()/memset wrappers, we can certainly use memblock directly :-)

If I read the memblock code correct something like this should do it.
Only as a principal idea - I may revist this another time.

	Sam


diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index a6bb102..3e8d102 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -148,6 +148,39 @@ phys_addr_t memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid)
 
 phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align);
 
+static inline void * memblock_boot_alloc_nid(phys_addr_t size,
+					     phys_addr_t align, int nid)
+{
+	phys_addr_t addr;
+	void * ptr;
+
+	addr = memblock_boot_alloc_nid(size, align, nid);
+	if (addr = 0)
+		return NULL;
+
+	void * ptr = __va(addr);
+	memset(ptr, 0, size);
+	return ptr;
+}
+
+static inline void * memblock_boot_alloc_try_nid(phys_addr_t size,
+						 phys_addr_t align, int nid)
+{
+	phys_addr_t addr;
+	void * ptr;
+
+	addr = memblock_boot_alloc_try_nid(size, align, nid);
+	if (addr = 0)
+		return NULL;
+
+	ptr = __va(addr);
+	memset(ptr, 0, size);
+	return ptr;
+}
+
+void * memblock_boot_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
+void * memblock_boot_alloc(phys_addr_t size, phys_addr_t align);
+
 /* Flags for memblock_alloc_base() amd __memblock_alloc_base() */
 #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
 #define MEMBLOCK_ALLOC_ACCESSIBLE	0

> 
