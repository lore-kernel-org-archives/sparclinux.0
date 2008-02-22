From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Feb 2008 20:33:31 +0000
Subject: [PATCH][SPARC64] fix section mismatch from kernel_map_range
Message-Id: <20080222203331.GF7154@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
WARNING: vmlinux.o(.text+0x4f980): Section mismatch in reference from the function kernel_map_range() to the function .init.text:__alloc_bootmem()
WARNING: vmlinux.o(.text+0x4f9cc): Section mismatch in reference from the function kernel_map_range() to the function .init.text:__alloc_bootmem()

alloc_bootmem() is only used during early init and for any subsequent
call to kernel_map_range() the program logic avoid the call.
So annotate kernel_map_range() with __ref to tell modpost to
ignore the reference to a __init function.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: David S. Miller <davem@davemloft.net>
---
diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 9e6bca2..b5c3041 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -1010,7 +1010,8 @@ static struct linux_prom64_registers pall[MAX_BANKS] __initdata;
 static int pall_ents __initdata;
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-static unsigned long kernel_map_range(unsigned long pstart, unsigned long pend, pgprot_t prot)
+static unsigned long __ref kernel_map_range(unsigned long pstart,
+					    unsigned long pend, pgprot_t prot)
 {
 	unsigned long vstart = PAGE_OFFSET + pstart;
 	unsigned long vend = PAGE_OFFSET + pend;
